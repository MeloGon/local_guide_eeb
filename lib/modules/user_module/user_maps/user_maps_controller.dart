import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:locals_guide_eeb/data/models/localbottom.dart';
import 'package:locals_guide_eeb/data/models/marcador.dart';
import 'package:locals_guide_eeb/data/models/sucursal.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

class UserMapsController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;
  String? _mapStyle;
  String? get mapStyle => _mapStyle;
  //lista para los marcadores
  List<Marcador>? _marcadores = [];
  List<Marcador>? get marcadores => _marcadores;
  //--------------------------

  //mi marker
  List<Marker>? _myMarker = [];
  List<Marker>? get myMarker => _myMarker;
  //--------------------------

  //para la distancia y el bottomsheet
  Position? _ubicacionActual;
  Position? get ubicacionActual => _ubicacionActual;
  List<LocalBottom>? _localsBottom = [];
  List<LocalBottom>? get localsBottom => _localsBottom;
  // --------------------------

  //evento de seleccion de un marker
  bool _isMarkerSelected = false;
  bool get isMarkerSelected => _isMarkerSelected;
  set setIsMarkerSelected(bool value) {
    _isMarkerSelected = value;
  }

  Sucursal? _sucursalTapped;
  Sucursal? get sucursalTapped => _sucursalTapped;

  String? _nameTap;
  String? get nameTap => _nameTap;

  String? _fotoTap;
  String? get fotoTap => _fotoTap;

  double? _distanceTap;
  double? get distanceTap => _distanceTap;

  List<Marker>? _markerTap = [];
  List<Marker>? get markerTap => _markerTap;
  //----------------------------

  //para las polylines
  List<Polyline>? _polis = [];
  List<Polyline>? get polis => _polis;
  List<Polyline>? _polisEmpty = [];
  List<Polyline>? get polisEmpty => _polisEmpty;
  //-----------------------------

  @override
  void onReady() {
    _getGeoLocationPosition();
    loadMarkers();
    super.onReady();
  }

  @override
  void onInit() {
    _isMarkerSelected = false;
    rootBundle.loadString('assets/map_style.text').then((value) {
      _mapStyle = value;
    });
    super.onInit();
  }

  goToDrawerMenu() async {
    Get.toNamed(AppRoutes.USERDRAWER);
  }

  //metodos para el marker personalizado
  Future<BitmapDescriptor> getMarkerImageFromUrl(
    String? url, {
    int? targetWidth,
  }) async {
    assert(url != null);
    final File markerImageFile =
        await DefaultCacheManager().getSingleFile(url!);
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

  void loadMarkers() async {
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .get()
        .then((docsLocal) {
      docsLocal.docs.forEach((local) async {
        String tempNLocal = local['nombreLocal'];
        //datos para el local del bottomsheet
        String categoriaLocal = local['categoria'];
        String colorCategoria = local['colorCategoria'];
        String fotoLocal = local['fotoLocal'];
        //-------------------------------------------
        //esta va ser la imagen para el custom marker
        final customMarker =
            await getMarkerImageFromUrl(local['fotoLocal'], targetWidth: 70);
        //-------------------------------------------
        local.reference.collection('Sucursales').get().then((docsSucursal) {
          docsSucursal.docs.forEach((sucursal) {
            Sucursal tempSucursal =
                Sucursal.fromDocumentSnapshot(documentSnapshot: sucursal);
            print('$tempNLocal yyyy ${tempSucursal.ubicacionLocal}');
            final marcadorTmp =
                Marcador(nombreLocal: tempNLocal, sucursal: tempSucursal);
            _marcadores!.add(marcadorTmp);
            //para parsear a ubicacion en la lista de marcadores
            List<String> latlong =
                sucursal['marker'].toString().substring(7, 44).split(",");
            double latitude = double.parse(latlong[0]);
            double longitude = double.parse(latlong[1]);
            LatLng location = LatLng(latitude, longitude);
            //--------------------------------------------------

            //locales o sucursales para el bottom
            final distance = calculateDistance(
                _ubicacionActual!.latitude,
                _ubicacionActual!.longitude,
                location.latitude,
                location.longitude);
            _localsBottom!.add(LocalBottom(
                nombreLocal: tempNLocal,
                colorCategoria: colorCategoria,
                categoria: categoriaLocal,
                sucursal: tempSucursal,
                distance: distance,
                fotoLocal: fotoLocal));
            //-----------------------------------
            _myMarker!.add(Marker(
                icon: customMarker,
                markerId: MarkerId(sucursal['marker']),
                position: location,
                infoWindow: InfoWindow(title: tempNLocal),
                draggable: true));
            update();
          });
        });
      });
    });
  }

  onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController!.setMapStyle(_mapStyle);
    update();
  }

  ///para calcular la distancia de las sucursales respecto a mi
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

  markerSelected(Sucursal sucursal, String foto, String localName) async {
    _isMarkerSelected = true;
    _sucursalTapped = sucursal;
    _nameTap = localName;
    _fotoTap = foto;
    //esta va ser la imagen para el custom marker
    final customMarker = await getMarkerImageFromUrl(foto, targetWidth: 70);
    //-------------------------------------------------
    //para parsear a ubicacion en la lista de marcadores
    List<String> latlong =
        sucursal.marker.toString().substring(7, 44).split(",");
    double latitude = double.parse(latlong[0]);
    double longitude = double.parse(latlong[1]);
    LatLng location = LatLng(latitude, longitude);
    //--------------------------------------------------
    //distancia de nosotros hacia el local tap
    _distanceTap = calculateDistance(_ubicacionActual!.latitude,
        _ubicacionActual!.longitude, location.latitude, location.longitude);
    //-------------------------------------------------
    _markerTap!.add(Marker(
        icon: customMarker,
        markerId: MarkerId(sucursal.marker!),
        position: location,
        infoWindow: InfoWindow(title: localName),
        draggable: true));
    getDirections(location.latitude, location.longitude,
        _ubicacionActual!.latitude, _ubicacionActual!.longitude);
    update();
  }

  closeTapMarker() async {
    _markerTap!.clear();
    _isMarkerSelected = false;
    update();
  }

  ///Metodos para dibujar las polylines
  getDirections(lat1, long1, lat2, long2) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBm12cGWg--j0pefW-1-qkAE6NHlTl034A',
      PointLatLng(lat1, long1),
      PointLatLng(lat2, long2),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print('error detectado ${result.errorMessage}');
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId(polylineCoordinates.toString());
    _polis!.add(Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    ));
    update();
  }

  //-------------------------------------------------------
  /* centrarVista() async {
    await _mapController!.getVisibleRegion();
    var left = min()
    var bounds = LatLngBounds(southwest: southwest, northeast: northeast)
    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50)
    _mapController.animateCamera(cameraUpdate)
  } */
}
