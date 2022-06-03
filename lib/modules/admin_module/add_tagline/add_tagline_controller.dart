import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';

class AddTaglineController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late TextEditingController txTagline;
  String? _currentTagline;
  String? get currentTagline => _currentTagline;

  @override
  void onReady() {
    showResources();
    super.onReady();
  }

  @override
  void onInit() {
    txTagline = TextEditingController();

    super.onInit();
  }

  showResources() async {
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("recursos")
        .get()
        .then((recursos) {
      _currentTagline = recursos["tagline"];
      update();
    });
  }

  updateTagline() async {
    await firebaseFirestore.collection("GuiaLocales").doc("recursos").update({
      "tagline": txTagline.text,
    }).then((value) {
      Get.snackbar(
          'Información', 'El tagline del aplicativo ha sido cambiado con éxito',
          backgroundColor: MyColors.white);
      Get.offAllNamed(AppRoutes.ADMINMENU);
    });
  }
}
