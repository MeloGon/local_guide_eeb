import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals_guide_eeb/data/models/sucursal.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class SucursalAdminController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Sucursal> sucursales = [];
  // Estos parametros necesarios para completar el flujo
  String? _idLocal;
  String? _nameLocal;
  String? _fotoLocal;
  // ---------------------
  //Parametros para editar
  final String _flujo = "editar";
  String? _idSucursalSeleccionado;
  // ----------------------
  QuerySnapshot? _querySnapshot;
  QuerySnapshot? get querySnapshot => _querySnapshot;
  @override
  void onInit() {
    _setArguments();
    super.onInit();
  }

  @override
  void onReady() {
    showSucursales();
    super.onReady();
  }

  _setArguments() {
    _idLocal = Get.arguments[0] as String;
    _nameLocal = Get.arguments[1] as String;
    _fotoLocal = Get.arguments[2] as String;
  }

  void showSucursales() async {
    sucursales.clear();

    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .get()
        .then((value) {
      _querySnapshot = value;
      update();
    });
    //     .then((value) {
    //   //print('${value.docs[0]['idSucursal']}');
    // });
  }

  //way 1
  goToEditSucursal(String idSucu) async {
    _idSucursalSeleccionado = idSucu;
    Get.toNamed(AppRoutes.ADDADDRESS, arguments: [
      _idLocal,
      _nameLocal,
      _fotoLocal,
      _flujo,
      _idSucursalSeleccionado,
    ]);
  }
}
