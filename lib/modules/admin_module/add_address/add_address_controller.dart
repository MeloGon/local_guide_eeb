import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals_guide_eeb/data/models/sucursal.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:random_string/random_string.dart';

class AddAdressController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String? _mapStyle;
  String? get mapStyle => _mapStyle;

  List<Marker>? _myMarker = [];
  List<Marker>? get myMarker => _myMarker;

  dynamic? _photoLocal;
  XFile? get photoLocal => _photoLocal;

  String? _nameLocal;
  String? get nameLocal => _nameLocal;
  String? idLocal;

  String? _phoneNumber;
  String? get phoneNumber => _phoneNumber;
  set phoneNumberSet(String value) {
    _phoneNumber = value;
  }

  String? _flujo;
  String? get flujo => _flujo;

  Sucursal? _infoSucursal;
  Sucursal? get infoSucursal => _infoSucursal;

  String? _idSucursalEditar;

  String? _idSucursal;

  late TextEditingController txAddress;
  //late TextEditingController txNumberPhone;
  late TextEditingController txNick;
  late TextEditingController txPwd;
  late TextEditingController txRepeatPwd;

  late GoogleMapController mapController;

  @override
  void onReady() {
    if (_flujo == 'editar') {
      _idSucursal = _idSucursalEditar;
      loadInfoSucursal();
    }
    super.onReady();
  }

  @override
  void onInit() {
    rootBundle.loadString('assets/map_style.text').then((value) {
      _mapStyle = value;
    });
    txAddress = TextEditingController();
    txNick = TextEditingController();
    //txNumberPhone = TextEditingController();
    txPwd = TextEditingController();
    txRepeatPwd = TextEditingController();
    _setArguments();
    super.onInit();
  }

  _setArguments() {
    _idSucursal = (randomAlphaNumeric(8));
    idLocal = Get.arguments[0] as String;
    _nameLocal = Get.arguments[1] as String;
    _photoLocal = Get.arguments[2];
    _flujo = Get.arguments[3] == '' ? 'agregar' : Get.arguments[3];
    _idSucursalEditar = Get.arguments[4] == '' ? '' : Get.arguments[4];
  }

  void goToAddDetailsLocalPage() async {
    Get.toNamed(AppRoutes.ADDDETAILSLOCAL, arguments: [
      _idSucursal,
      _myMarker![0].position,
      idLocal,
      _nameLocal,
      _photoLocal,
      txAddress.text,
      _phoneNumber,
      txNick.text,
      txPwd.text,
      txRepeatPwd.text,
      _flujo,
    ]);
  }

  putMarker(LatLng tapPoint) {
    _myMarker = [];
    _myMarker!.add(Marker(
        markerId: MarkerId(tapPoint.toString()),
        position: tapPoint,
        draggable: true));
    print('posicion Esta es la latitud y la longitud $tapPoint');
    print('posicion en lista ${_myMarker![0].position}');
    update();
  }

  loadInfoSucursal() async {
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .get()
        .then((value) {
      //print(value['ubicacionLocal']);
      //print(value['telefonoLocal']);
      _infoSucursal = Sucursal.fromDocumentSnapshot(documentSnapshot: value);
      txAddress.text = _infoSucursal!.ubicacionLocal;
      txNick.text = infoSucursal!.username;
      txPwd.text = infoSucursal!.pwdLocal;
      _phoneNumber = _infoSucursal!.telefonoLocal;

      //esto es para parsear el string a latlong
      List<String> latlong =
          value['marker'].toString().substring(7, 44).split(",");
      double latitude = double.parse(latlong[0]);
      double longitude = double.parse(latlong[1]);
      LatLng location = LatLng(latitude, longitude);
      // ---------
      _myMarker!.add(Marker(
          markerId: MarkerId(value['marker']),
          position: location,
          draggable: true));
      update();
    });
  }
}
