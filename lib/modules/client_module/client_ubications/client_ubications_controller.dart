import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals_guide_eeb/data/models/sucursal.dart';

class ClientUbicationsController extends GetxController {
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

  @override
  void onReady() {
    loadDataForDashboard();
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
  }

  loadDataForDashboard() async {
    //print(txUser!.text);
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
          print(element["marker"]);
          final sucursal =
              Sucursal.fromDocumentSnapshot(documentSnapshot: element);
          List<String> latlong =
              element['marker'].toString().substring(7, 44).split(",");
          double latitude = double.parse(latlong[0]);
          double longitude = double.parse(latlong[1]);
          LatLng location = LatLng(latitude, longitude);
          _listMarkers!.add(location);
          _sucursales!.add(sucursal);
          _myMarker!.add(Marker(
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
