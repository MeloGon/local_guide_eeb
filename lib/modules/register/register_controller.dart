import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class RegisterController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
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
      Get.toNamed(AppRoutes.ADMINMENU);
      return;
    } else {
      Get.snackbar('Ups algo salió mal',
          'Por favor pongase en contacto con el equipo de desarrollo. Gracias');
    }
  }
}
