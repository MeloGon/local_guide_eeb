import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:random_string/random_string.dart';

class RegisterController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String? _idUser;

  @override
  void onInit() {
    _idUser = (randomAlphaNumeric(8));
    super.onInit();
  }

  void goToRegisterByPhone() async {
    Get.toNamed(AppRoutes.REGISTERPHONE);
  }

  registerWithGmail() async {
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
      print('este es el correo y pass ${user.displayName}');
      await firebaseFirestore
          .collection("GuiaLocales")
          .doc("admin")
          .collection("Usuarios")
          .doc(_idUser)
          .set({
        'idUser': _idUser,
        'email': user.email,
        'pwd': 'emptyForNow',
        'nombreUser ': user.displayName,
        'photoUser': user.photoURL,
      });
      Get.toNamed(AppRoutes.ADMINMENU);
      return;
    } else {
      Get.snackbar('Ups algo salió mal',
          'Por favor pongase en contacto con el equipo de desarrollo. Gracias');
    }
  }
}
