import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals_guide_eeb/data/models/comentario.dart';
import 'package:locals_guide_eeb/data/models/comment_like.dart';
import 'package:locals_guide_eeb/data/models/foto.dart';
import 'package:locals_guide_eeb/data/models/localubication.dart';
import 'package:locals_guide_eeb/data/models/plato.dart';
import 'package:locals_guide_eeb/data/models/sucursal.dart';
import 'package:http/http.dart' as http;
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'dart:ui' as ui;

import 'package:random_string/random_string.dart';

class ClientUbicationsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  QuerySnapshot? _querySnapshot;
  //parametros que llegan
  String? _idLocal,
      _nombreLocal,
      _fotoLocal,
      _idSucursal,
      _idUser,
      _displayName,
      _photoUrl;
  String? get nombreLocal => _nombreLocal;
  String? get fotoLocal => _fotoLocal;
  String? get idSucursal => _idSucursal;
  int _indice = 0;
  int get indice => _indice;
  //--------------------
  List<LatLng>? _listMarkers = [];
  List<LatLng>? get listMarkers => _listMarkers;
  List<Sucursal>? _sucursales = [];
  List<Sucursal>? get sucursales => _sucursales;
  List<Marker>? _myMarker = [];
  List<Marker>? get myMarker => _myMarker;
  List<Foto>? _listFoto = [];
  List<Foto>? get listFoto => _listFoto;
  TabController? _tabController;
  TabController? get tabController => _tabController;
  int? _indexTab;
  int? get indexTab => _indexTab;
  bool _loadingUbications = true;
  bool get loadingUbications => _loadingUbications;
  //para las fotos del tab de momentos
  bool _areLoadingPhotos = true;
  bool get areLoadingPhotos => _areLoadingPhotos;
  XFile? _fotoMomentos;
  XFile? get fotoMomentos => _fotoMomentos;
  CloudinaryResponse? response;
  final cloudinary = CloudinaryPublic('en-el-blanco', 'o2pugvho', cache: false);
  QuerySnapshot? localesQuery;
  //-----------------------------------

  //para calcular la distancia de la ubicacion actual y los locales
  List<LocalUbication>? _ubicaciones = [];
  List<LocalUbication>? get ubicaciones => _ubicaciones;
  Position? _ubicacionActual;
  //---------------------------

  late GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;
  String? _mapStyle;

  //para los comentarios
  int? _tipoUsuario;
  int? get tipoUsuario => _tipoUsuario;
  late TextEditingController txPost;
  List<CommentLike>? _listComentarios = [];
  List<CommentLike>? get listComentarios => _listComentarios;
  bool? _darLike = true;
  bool? get darLike => _darLike;
  List<Plato>? _platosLista = [];
  List<Plato>? get platosLista => _platosLista;
  List<Plato>? _platosSeleccionados = [];
  List<Plato>? get platosSeleccionados => _platosSeleccionados;
  String? _postPlatos;
  //--------------------------------------

  @override
  void onReady() {
    loadDataForDashboard();
    loadDataforMomets();
    loadComments();
    loadDishes();
    _tabController!.addListener(cambiandoTabs);
    _getGeoLocationPosition();
    // make sure to initialize before map loading
    super.onReady();
  }

  @override
  void onInit() {
    rootBundle.loadString('assets/maps/map_style.txt').then((string) {
      _mapStyle = string;
    });
    txPost = TextEditingController();
    _loadingUbications = true;
    _indice = Get.arguments[4] as int;
    setArguments();
    super.onInit();
  }

  setArguments() {
    _idLocal = Get.arguments[0] as String;
    _nombreLocal = Get.arguments[1] as String;
    _fotoLocal = Get.arguments[2] as String;
    _idSucursal = Get.arguments[3] as String;
    _tipoUsuario = Get.arguments[5] as int;
    if (_tipoUsuario == 2) {
      _idUser = Get.arguments[6] as String;
      _displayName = Get.arguments[7] as String;
      _photoUrl = Get.arguments[8] as String;
    }
    _tabController =
        TabController(length: 3, initialIndex: _indice, vsync: this);
  }

  onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController!.setMapStyle(_mapStyle);
    update();
  }

  cambiandoTabs() {
    _indexTab = _tabController!.index;
    _indice = _tabController!.index;
    update();
  }

  //metodos para el marker personalizado
  Future<BitmapDescriptor> getMarkerImageFromUrl(
    String? url, {
    int? targetWidth,
  }) async {
    assert(url != null);
    final File markerImageFile =
        await DefaultCacheManager().getSingleFile(_fotoLocal!);
    if (targetWidth != null) {
      return convertImageFileToBitmapDescriptor(markerImageFile, size: 100);
    } else {
      Uint8List markerImageBytes = await markerImageFile.readAsBytes();
      return BitmapDescriptor.fromBytes(markerImageBytes);
    }
  }

  static Future<BitmapDescriptor> convertImageFileToBitmapDescriptor(
      File imageFile,
      {int size = 100,
      bool addBorder = false,
      Color borderColor = Colors.red,
      double borderSize = 10,
      Color titleColor = Colors.transparent,
      Color titleBackgroundColor = Colors.transparent}) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color;
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    final double radius = size / 2;

    //make canvas clip path to prevent image drawing over the circle
    final Path clipPath = Path();
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        Radius.circular(100)));
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(size / 2.toDouble(), size + 20.toDouble(), 10, 10),
        Radius.circular(100)));
    canvas.clipPath(clipPath);

    //paintImage
    final Uint8List imageUint8List = await imageFile.readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(imageUint8List);
    final ui.FrameInfo imageFI = await codec.getNextFrame();
    paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        image: imageFI.image,
        fit: BoxFit.cover);

    //convert canvas as PNG bytes
    final _image = await pictureRecorder
        .endRecording()
        .toImage(size, (size * 1.1).toInt());
    final data = await _image.toByteData(format: ui.ImageByteFormat.png);

    //convert PNG bytes as BitmapDescriptor
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
  //---------------------------------------------------------------------------

  //metodos para subir foto en el tab de momentos
  addMoment({String? option}) async {
    switch (option) {
      case "camara":
        _fotoMomentos = await ImagePicker().pickImage(
            source: ImageSource.camera,
            imageQuality: 70,
            maxWidth: 1024,
            maxHeight: 768);
        update();
        break;
      case "galeria":
        _fotoMomentos = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            imageQuality: 70,
            maxWidth: 1024,
            maxHeight: 768);
        update();
        break;
    }

    if (_fotoMomentos != null) {
      var idFotoTemp = (randomAlphaNumeric(8));
      try {
        response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(_fotoMomentos!.path,
              resourceType: CloudinaryResourceType.Image),
        );
        await firebaseFirestore
            .collection("GuiaLocales")
            .doc("admin")
            .collection("Locales")
            .doc(_idLocal)
            .get()
            .then((local) {
          local.reference
              .collection("Sucursales")
              .doc(_idSucursal)
              .get()
              .then((sucursal) {
            sucursal.reference.collection("Fotografias").doc(idFotoTemp).set({
              'idFoto': idFotoTemp,
              'likes': '0',
              'pathFoto': response!.secureUrl
            });

            //------------------------------------------
          });
        }).then((value) {
          Get.snackbar("Aviso", "Espere un momento en lo que carga la imagen");
          _listFoto!.clear();
          loadDataforMomets();
          update();
        });
      } on CloudinaryException catch (e) {
        print(e.message);
        print(e.request);
      }
    }
  }
  //---------------------------------------------------------------------------

  loadDataForDashboard() async {
    //print(txUser!.text);
    final customMarker =
        await getMarkerImageFromUrl(_fotoLocal!, targetWidth: 70);
    _loadingUbications = true;
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .get()
        .then((value) {
      value.reference.collection("Sucursales").get().then((value) {
        value.docs.forEach((element) {
          //esto es para parsear el string a latlong
          //print(element["marker"]);
          final sucursal =
              Sucursal.fromDocumentSnapshot(documentSnapshot: element);

          List<String> latlong =
              element['marker'].toString().substring(7, 44).split(",");
          double latitude = double.parse(latlong[0]);
          double longitude = double.parse(latlong[1]);
          LatLng location = LatLng(latitude, longitude);
          _listMarkers!.add(location);
          _sucursales!.add(sucursal);
          final distance = calculateDistance(
              _ubicacionActual!.latitude,
              _ubicacionActual!.longitude,
              location.latitude,
              location.longitude);
          //centerView(location);
          ubicaciones!
              .add(LocalUbication(sucursal: sucursal, distance: distance));
          _loadingUbications = false;
          _myMarker!.add(Marker(
              icon: customMarker,
              markerId: MarkerId(element['marker']),
              position: location,
              draggable: true));
          update();
          // ---------
        });
      });
    });
  }

  loadDataforMomets() async {
    //esto es para las fotografias
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .get()
        .then((local) {
      local.reference
          .collection("Sucursales")
          .doc(_idSucursal)
          .get()
          .then((sucursal) {
        sucursal.reference.collection("Fotografias").get().then((fotografias) {
          for (var foto in fotografias.docs) {
            final photo = Foto.fromDocumentSnapshot(documentSnapshot: foto);
            _listFoto!.add(photo);
            update();
          }
          _areLoadingPhotos = false;
          update();
        });
      });
    });
  }

  calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error(
          'Los servicios de localizacion estan deshabilitados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Los permisos de localizacion han sido denegados');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Los permisos de localizacion han sido denegados permanentemente');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _ubicacionActual = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  postComment() async {
    List<String> platosPost = [];
    platosSeleccionados!.forEach((element) {
      platosPost.add(element.nombrePlato);
    });
    final str = platosPost.join('\n');
    //se necesita likes,idcomment,idusuario,contenidoPost
    //foto usuario, nombre usuario, fecha
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .get()
        .then((sucursal) {
      final idComentario = (randomAlphaNumeric(8));
      sucursal.reference.collection("Comentarios").doc(idComentario).set({
        'idComentario': idComentario,
        'likes': 0,
        'idUsuario': _idUser,
        'fotoUsuario': _photoUrl,
        'nombreUsuario': _displayName,
        'post': str,
        'fecha': DateTime.now().toString(),
        'nombreLocal': _nombreLocal,
      });
    }).then((value) {
      _listComentarios!.clear();
      loadComments();
    });
  }

  loadComments() async {
    //si el tipo es el usuario final
    if (tipoUsuario == 2) {
      await firebaseFirestore
          .collection("GuiaLocales")
          .doc("admin")
          .collection("Locales")
          .doc(_idLocal)
          .collection("Sucursales")
          .doc(_idSucursal)
          .collection("Comentarios")
          .get()
          .then((comentariosDocs) async {
        for (var comentario in comentariosDocs.docs) {
          final comment =
              Comentario.fromDocumentSnapshot(documentSnapshot: comentario);
          var isLiked = await checkIfCommentLikeMe(comment, _idUser!);
          _listComentarios!
              .add(CommentLike(comentario: comment, liked: isLiked));

          update();
        }
      });
    }
    //si el tipo es el usuario local
    else {
      await firebaseFirestore
          .collection("GuiaLocales")
          .doc("admin")
          .collection("Locales")
          .doc(_idLocal)
          .collection("Sucursales")
          .doc(_idSucursal)
          .collection("Comentarios")
          .get()
          .then((comentariosDocs) async {
        for (var comentario in comentariosDocs.docs) {
          final comment =
              Comentario.fromDocumentSnapshot(documentSnapshot: comentario);
          var isLiked = await checkIfCommentLikeMe(comment, _idLocal!);
          _listComentarios!
              .add(CommentLike(comentario: comment, liked: isLiked));
          update();
        }
      });
    }
  }

  giveLike(Comentario comentario) async {
    //al dar like
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .collection("Comentarios")
        .doc(comentario.idComentario)
        .update({
      'likes': comentario.likes + 1,
    });
    comentario.likes = comentario.likes + 1;
    _darLike = false;
    //--------------
    //crear la coleccion de personas que dieron like
    final idPersonaQueLeGusta = (randomAlphaNumeric(8));
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .collection("Comentarios")
        .doc(comentario.idComentario)
        .collection("UsuarioQueleGusta")
        .doc(idPersonaQueLeGusta)
        .set({
      'idUsuario': (tipoUsuario == 2) ? _idUser : _idLocal,
      'nombreUsuario': _displayName,
      'idComentario': comentario.idComentario,
    });
    //--------------
    // checkIfCommentLikeMe(comentario,_idUser!);
    update();
  }

  checkIfCommentLikeMe(Comentario comentario, String idUser) async {
    var query = await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .collection("Comentarios")
        .doc(comentario.idComentario)
        .collection("UsuarioQueleGusta")
        .where('idUsuario', isEqualTo: idUser)
        .get();

    if (query.size > 0) {
      update();
      return true;
    } else {
      update();
      return false;
    }
  }

  putOffLike(Comentario comentario) async {
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .collection("Comentarios")
        .doc(comentario.idComentario)
        .update({
      'likes': comentario.likes - 1,
    });
    comentario.likes = comentario.likes - 1;
    _darLike = true;
    //quitar el usuario la coleccion de personas que dieron like
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .collection("Comentarios")
        .doc(comentario.idComentario)
        .collection("UsuarioQueleGusta")
        .where('idUsuario', isEqualTo: (tipoUsuario == 2) ? _idUser : _idLocal)
        .get()
        .then((usuarioQueLesGustaDocs) {
      usuarioQueLesGustaDocs.docs.forEach((usuarioQueLesGusta) {
        usuarioQueLesGusta.reference.delete();
      });
    });
    //--------------
    update();
  }

  loadDishes() async {
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .collection("Platos")
        .get()
        .then((platos) {
      platos.docs.forEach((plato) {
        final dish = Plato.fromDocumentSnapshot(documentSnapshot: plato);
        _platosLista!.add(dish);
        update();
      });
    });
  }

  seleccionPlatos(values) {
    _platosSeleccionados!.addAll(values);
    update();
  }

  ///centra la vista entre ubicacion actual y sucursal seleccioanda
  centerView(Sucursal sucursal) async {
    Get.snackbar(
        'Información', 'Estamos ajustando la vista respecto a tu ubicación ...',
        colorText: MyColors.blackBg, backgroundColor: MyColors.white);
    List<String> latlong =
        sucursal.marker.toString().substring(7, 44).split(",");
    double latitude = double.parse(latlong[0]);
    double longitude = double.parse(latlong[1]);
    LatLng location = LatLng(latitude, longitude);
    //espera a que el mapa este listo
    await _mapController!.getVisibleRegion();
    var left = min(_ubicacionActual!.latitude, location.latitude);
    var right = max(_ubicacionActual!.latitude, location.latitude);
    var top = max(_ubicacionActual!.longitude, location.longitude);
    var bottom = min(_ubicacionActual!.longitude, location.longitude);
    var bounds = LatLngBounds(
        southwest: LatLng(left, bottom), northeast: LatLng(right, top));
    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    _mapController!.animateCamera(cameraUpdate);
  }
}
