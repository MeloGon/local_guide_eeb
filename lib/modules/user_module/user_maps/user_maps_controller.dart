import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:locals_guide_eeb/data/models/filter.dart';
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

  // para hacer la busqueda o filtrado en el bottomsheet
  List<LocalBottom>? _foundLocalsBottom = [];
  List<LocalBottom>? get foundLocalsBottom => _foundLocalsBottom;
  // ---------------------------

  //evento de seleccion de un marker
  bool _isMarkerSelected = false;
  bool get isMarkerSelected => _isMarkerSelected;
  set setIsMarkerSelected(bool value) {
    _isMarkerSelected = value;
  }

  Sucursal? _sucursalTapped;
  Sucursal? get sucursalTapped => _sucursalTapped;

  String? _idLocal;
  String? get idLocal => _idLocal;

  String? _nameTap;
  String? get nameTap => _nameTap;

  String? _fotoTap;
  String? get fotoTap => _fotoTap;

  double? _distanceTap = 0;
  double? get distanceTap => _distanceTap;

  String? _idSucursalTap;
  String? get idSucursalTap => _idSucursalTap;

  List<Marker>? _markerTap = [];
  List<Marker>? get markerTap => _markerTap;
  //----------------------------

  //para las polylines
  List<Polyline>? _polis = [];
  List<Polyline>? get polis => _polis;
  List<Polyline>? _polisEmpty = [];
  List<Polyline>? get polisEmpty => _polisEmpty;
  //-----------------------------

  //parametros que llegan
  List<Filter>? _filtros = [];
  String? _idUser, _displayName, _photoUrl;
  String? get displayName => _displayName;
  String? get photoUrl => _photoUrl;
  int? _tipoUsuario;
  double? _distanceFilter;
  double? get distanceFilter => _distanceFilter;
  double? _priceFilter;
  double? get priceFilter => _priceFilter;

  //-------------------

  //controlando altura
  double? _heightX;
  double? get heightX => _heightX;
  //
  @override
  void onReady() {
    loadMarkers();
    _foundLocalsBottom = _localsBottom;
    super.onReady();
  }

  @override
  void onInit() {
    _heightX = .4;
    _isMarkerSelected = false;
    rootBundle.loadString('assets/maps/map_style.txt').then((string) {
      _mapStyle = string;
    });
    _getGeoLocationPosition();
    setArguments();
    super.onInit();
  }

  setArguments() {
    _filtros = Get.arguments[0] as List<Filter>;
    _idUser = Get.arguments[1];
    _displayName = Get.arguments[2];
    _photoUrl = Get.arguments[3];
    _tipoUsuario = Get.arguments[4];
    _distanceFilter = Get.arguments[5];
    _priceFilter = Get.arguments[6];
  }

  goToDrawerMenu() async {
    Get.toNamed(AppRoutes.USERDRAWER, arguments: [
      _idUser,
      _displayName,
      _photoUrl,
    ]);
  }

  void loadMarkers() async {
    if (_filtros!.isEmpty) {
      await firebaseFirestore
          .collection("GuiaLocales")
          .doc("admin")
          .collection("Locales")
          .get()
          .then((docsLocal) {
        docsLocal.docs.forEach((local) async {
          String tempNLocal = local['nombreLocal'];
          String tempIdLocal = local['idLocal'];
          //datos para el local del bottomsheet
          String categoriaLocal = local['categoria'];
          String colorCategoria = local['colorCategoria'];
          String fotoLocal = local['fotoLocal'];
          //-------------------------------------------
          //esta va ser la imagen para el custom marker
          //-------------------------------------------
          local.reference
              .collection('Sucursales')
              .get()
              .then((docsSucursal) async {
            for (var sucursal in docsSucursal.docs) {
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

              //para parsear el coklor recibido
              final color = colorCategoria;
              String valueString = color.split('(0x')[1].split(')')[0];
              int colorParseado = int.parse(valueString, radix: 16);
              //-------------------------------

              //obtiene el precio de la sucursal
              final precio = sucursal['precioLocal'];

              //locales o sucursales para el bottom
              final distance = calculateDistance(
                  _ubicacionActual!.latitude,
                  _ubicacionActual!.longitude,
                  location.latitude,
                  location.longitude);

              //compara las distancias y hace funcar el filtro
              if (distance <= _distanceFilter && precio <= _priceFilter) {
                _localsBottom!.add(LocalBottom(
                  nombreLocal: tempNLocal,
                  colorCategoria: colorCategoria,
                  categoria: categoriaLocal,
                  sucursal: tempSucursal,
                  distance: distance,
                  fotoLocal: fotoLocal,
                  idLocal: tempIdLocal,
                ));

                _myMarker!.add(
                  Marker(
                    infoWindow: InfoWindow(
                        snippet: 'presiona para mas info.',
                        title: tempNLocal,
                        onTap: () {
                          markerSelected(tempSucursal, fotoLocal, tempNLocal,
                              tempIdLocal, colorParseado);
                          update();
                        }),
                    position: location,
                    markerId: MarkerId(sucursal['marker']),
                    icon: await MarkerIcon.downloadResizePictureCircle(
                        fotoLocal,
                        size: 90,
                        addBorder: true,
                        borderColor: Color(colorParseado),
                        borderSize: 20),
                  ),
                );
              }

              update();
            }
          });
        });
      });
    } else {
      await firebaseFirestore
          .collection("GuiaLocales")
          .doc("admin")
          .collection("Locales")
          .get()
          .then((docsLocal) {
        docsLocal.docs.forEach((local) async {
          String tempNLocal = local['nombreLocal'];
          String tempIdLocal = local['idLocal'];
          //datos para el local del bottomsheet
          String categoriaLocal = local['categoria'];
          String colorCategoria = local['colorCategoria'];
          String fotoLocal = local['fotoLocal'];
          for (var filtro in _filtros!) {
            if (filtro.nombre == categoriaLocal) {
              local.reference
                  .collection('Sucursales')
                  .get()
                  .then((docsSucursal) {
                docsSucursal.docs.forEach((sucursal) async {
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

                  //para parsear el coklor recibido
                  final color = colorCategoria;
                  String valueString = color.split('(0x')[1].split(')')[0];
                  int colorParseado = int.parse(valueString, radix: 16);
                  //-------------------------------

                  //locales o sucursales para el bottom
                  final distance = calculateDistance(
                      _ubicacionActual!.latitude,
                      _ubicacionActual!.longitude,
                      location.latitude,
                      location.longitude);

                  //compara las distancias y hace funcar el filtro
                  if (distance <= _distanceFilter) {
                    _localsBottom!.add(LocalBottom(
                      nombreLocal: tempNLocal,
                      colorCategoria: colorCategoria,
                      categoria: categoriaLocal,
                      sucursal: tempSucursal,
                      distance: distance,
                      fotoLocal: fotoLocal,
                      idLocal: tempIdLocal,
                    ));

                    _myMarker!.add(
                      Marker(
                        infoWindow: InfoWindow(
                            snippet: 'presiona para mas info.',
                            title: tempNLocal,
                            onTap: () {
                              markerSelected(tempSucursal, fotoLocal,
                                  tempNLocal, tempIdLocal, colorParseado);
                              update();
                            }),
                        position: location,
                        markerId: MarkerId(sucursal['marker']),
                        icon: await MarkerIcon.downloadResizePictureCircle(
                            fotoLocal,
                            size: 90,
                            addBorder: true,
                            borderColor: Color(colorParseado),
                            borderSize: 20),
                      ),
                    );
                  }

                  update();
                });
              });
            }
          }
          //-------------------------------------------
        });
      });
    }
    update();
  }

  ///para la busqueda desde el textfield
  void runFilter(String enteredKeyword) {
    List<LocalBottom> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _localsBottom!;
    } else {
      results = _localsBottom!
          .where((local) => local.nombreLocal!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    _foundLocalsBottom = results;
    update();
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

  markerSelected(Sucursal sucursal, String foto, String localName,
      String idlocal, int colorParseado) async {
    print('el id de la sucursal es ${sucursal.idSucursal}');
    _isMarkerSelected = true;
    _sucursalTapped = sucursal;
    _nameTap = localName;
    _fotoTap = foto;
    _idLocal = idlocal;
    _idSucursalTap = sucursal.idSucursal;

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
        icon: await MarkerIcon.downloadResizePictureCircle(foto,
            size: 150,
            addBorder: true,
            borderColor: Color(colorParseado),
            borderSize: 20),
        markerId: MarkerId(sucursal.marker!),
        position: location,
        infoWindow: InfoWindow(title: localName),
        draggable: true));

    getDirections(location.latitude, location.longitude,
        _ubicacionActual!.latitude, _ubicacionActual!.longitude);

    centerView(location);
    update();
  }

  closeTapMarker() async {
    _markerTap!.clear();
    _polis!.clear();
    _isMarkerSelected = false;
    closedPanel();
    update();
  }

  ///centra la vista entre ubicacion actual y sucursal seleccioanda
  centerView(LatLng location) async {
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

  goToLocalProfile() async {
    Get.toNamed(AppRoutes.CLIENTUBICATIONS, arguments: [
      _idLocal,
      _nameTap,
      _fotoTap,
      _idSucursalTap,
      0,
      _tipoUsuario,
      _idUser,
      _displayName,
      _photoUrl,
    ]);
  }

  goToReserve() async {
    Get.toNamed(AppRoutes.USERRESERVE, arguments: [
      _idLocal,
      _nameTap,
      _fotoTap,
      _idSucursalTap,
      _idUser,
      _displayName,
    ]);
  }

  openedPanel() {
    _heightX = .1;
    update();
  }

  closedPanel() {
    _heightX = .4;
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
