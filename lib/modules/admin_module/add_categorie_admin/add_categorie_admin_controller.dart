import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:locals_guide_eeb/data/models/categorie.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:random_string/random_string.dart';

class AddCategorieAdminController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late TextEditingController txNombreCat;
  late String txColorCat;
  late String idCate;
  //parametros que vienen
  String? _flujo;
  String? get flujo => _flujo;
  String? _idCat;
  // ------------------------
  Category? categoriaEditar;
  int _valueColor = 0;
  int get valueColor => _valueColor;

  @override
  void onReady() {
    if (_flujo == 'editar') {
      loadCategory();
    }
    super.onReady();
  }

  @override
  void onInit() {
    txNombreCat = TextEditingController();
    idCate = (randomAlphaNumeric(8));
    setArguments();
    super.onInit();
  }

  setArguments() {
    _flujo = Get.arguments[0] as String;
    if (_flujo == 'editar') {
      _idCat = Get.arguments[1] as String;
    }
  }

  void addCategory() async {
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Categorias")
        .doc(idCate)
        .set({
      'idCategoria': idCate,
      'nombreCategoria': txNombreCat.text,
      'color': txColorCat,
    });
    Get.back();
    Get.snackbar('La categoria ha sido agregada',
        'Porfavor deslize hacia abajo para actualizar la página',
        colorText: MyColors.blackBg, backgroundColor: MyColors.white);
  }

  void loadCategory() async {
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Categorias")
        .doc(_idCat)
        .get()
        .then((value) {
      categoriaEditar = Category.fromDocumentSnapshot(documentSnapshot: value);
      txNombreCat = TextEditingController(text: categoriaEditar!.nombre);
      final color = categoriaEditar!.color;
      String valueString = color.split('(0x')[1].split(')')[0];
      _valueColor = int.parse(valueString, radix: 16);
      update();
    });
  }

  void editCategoria() async {
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Categorias")
        .doc(_idCat)
        .set({
      'idCategoria': _idCat,
      'nombreCategoria': txNombreCat.text,
      'color': txColorCat,
    });
    Get.back();
    Get.snackbar('La categoria ha sido agregada',
        'Porfavor deslize hacia abajo para actualizar la página',
        colorText: MyColors.blackBg, backgroundColor: MyColors.white);
  }
}
