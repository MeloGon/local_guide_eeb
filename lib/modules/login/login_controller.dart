import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';

class LoginController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  TextEditingController? _txUser;
  TextEditingController? get txUser => _txUser;
  TextEditingController? _txPass;
  TextEditingController? get txPass => _txPass;

  bool existLocal = false;

  QuerySnapshot? _querySnapshot;

  @override
  void onInit() {
    setArguments();
    super.onInit();
  }

  setArguments() {
    _txUser = TextEditingController();
    _txPass = TextEditingController();
  }

  void goToAdminMenu() async {
    Get.toNamed(AppRoutes.ADMINMENU);
  }

  void goToClientMenu() async {
    Get.toNamed(AppRoutes.CLIENTMENU);
  }

  searchLocalUser() async {
    Get.snackbar('Validando', 'Espere un momento por favor ...');
    print(txUser!.text);
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .get()
        .then((value) {
      _querySnapshot = value;
      _querySnapshot!.docs.forEach(
        (element) {
          element.reference.collection("Sucursales").get().then((value) {
            value.docs.forEach((element) {
              print(element.data());
              // if (element["username"] == "nickname_editado" &&
              //     element["pwdLocal"] == "dsadkasd")
              if (element["username"] == txUser!.text &&
                  element["pwdLocal"] == txPass!.text) {
                Get.toNamed(AppRoutes.CLIENTMENU);
              }
            });
          });
        },
      );
    });
  }
}
