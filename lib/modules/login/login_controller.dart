import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  void goToUserMenu() async {
    Get.toNamed(AppRoutes.USERMENU);
  }

  searchLocalUser() async {
    if (txUser!.text.isEmpty || txPass!.text.isEmpty) {
      Get.snackbar('Advertencia',
          'Tiene que ingresar una cuenta y una contraseña validos para poder continuar',
          backgroundColor: MyColors.white, colorText: MyColors.blackBg);
    } else {
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
          (firstElement) {
            firstElement.reference.collection("Sucursales").get().then((value) {
              value.docs.forEach((element) {
                //print(element.data());
                // if (element["username"] == "nickname_editado" &&
                //     element["pwdLocal"] == "dsadkasd")
                if (element["username"] == txUser!.text &&
                    element["pwdLocal"] == txPass!.text) {
                  // print(
                  //     'este es el local de la que contiene la sucursal ${firstElement.data()}');
                  Get.toNamed(AppRoutes.CLIENTMENU, arguments: [
                    element["idSucursal"],
                    firstElement["idLocal"],
                  ]);
                }
              });
            });
          },
        );
      });
      //    loginWithGoogleMail();
    }
  }

  /* loginWithGoogleMail() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final User? user = authResult.user;
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (user!.uid == currentUser!.uid) {
      Get.toNamed(AppRoutes.USERMENU);
      return;
    } else {
      Get.snackbar('Ups algo salió mal',
          'Por favor pongase en contacto con el equipo de desarrollo. Gracias');
    }
  } */
}
