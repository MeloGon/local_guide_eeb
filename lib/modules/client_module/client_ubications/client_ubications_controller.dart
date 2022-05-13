import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals_guide_eeb/data/models/foto.dart';
import 'package:locals_guide_eeb/data/models/sucursal.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

class ClientUbicationsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  QuerySnapshot? _querySnapshot;
  //parametros que llegan
  String? _idLocal, _nombreLocal, _fotoLocal;
  String? get nombreLocal => _nombreLocal;
  String? get fotoLocal => _fotoLocal;
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
  XFile? _fotoMomentos;
  XFile? get fotoMomentos => _fotoMomentos;
  CloudinaryResponse? response;
  final cloudinary = CloudinaryPublic('en-el-blanco', 'o2pugvho', cache: false);
  //-----------------------------------

  @override
  void onReady() {
    loadDataForDashboard();
    _tabController!.addListener(cambiandoTabs);
    // make sure to initialize before map loading
    super.onReady();
  }

  @override
  void onInit() {
    setArguments();
    super.onInit();
  }

  setArguments() {
    _idLocal = Get.arguments[0] as String;
    _nombreLocal = Get.arguments[1] as String;
    _fotoLocal = Get.arguments[2] as String;
    _tabController = TabController(length: 3, vsync: this);
  }

  cambiandoTabs() {
    _indexTab = _tabController!.index;
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
        _fotoMomentos =
            await ImagePicker().pickImage(source: ImageSource.camera);
        update();
        break;
      case "galeria":
        _fotoMomentos =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        update();
        break;
    }

    if (_fotoMomentos != null) {
      try {
        response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(_fotoMomentos!.path,
              resourceType: CloudinaryResourceType.Image),
        );
        print(response!.secureUrl);
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
          //esto es para las fotografias
          element.reference.collection("Fotografias").get().then((fotografias) {
            for (var foto in fotografias.docs) {
              final photo = Foto.fromDocumentSnapshot(documentSnapshot: foto);
              listFoto!.add(photo);
              update();
            }
          });
          //------------------------------------------
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
}
