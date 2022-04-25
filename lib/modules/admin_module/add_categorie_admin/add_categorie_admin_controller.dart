import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/data/models/categorie.dart';
import 'package:random_string/random_string.dart';

class AddCategorieAdminController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late TextEditingController txNombreCat;
  late String txColorCat;
  late String idCate;

  @override
  void onInit() {
    txNombreCat = new TextEditingController();
    idCate = (randomAlphaNumeric(8));
    super.onInit();
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
  }
}
