import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/data/models/sucursal.dart';

class SucursalAdminController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Sucursal> sucursales = [];
  String? _idLocal;
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

    // return await firebaseFirestore
    //     .collection("GuiaLocales")
    //     .doc("admin")
    //     .collection("Locales")
    //     .where('idLocal', isEqualTo: _idSucursal)
    //     .get()
    //     .then((value) {
    //   final sucursal = Sucursal.fromDocumentSnapshot(documentSnapshot: value);
    //   sucursales.add(sucursal);
    //   update();
    // });
  }
}
