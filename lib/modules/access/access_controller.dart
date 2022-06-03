import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class AccessController extends GetxController
    with GetSingleTickerProviderStateMixin {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late AnimationController animationController;
  late Animation<double> animationLogo;
  String? _tagline, _urlFoto;
  bool _loading = false;
  bool get loading => _loading;
  String? get tagLine => _tagline;
  String? get urlFoto => _urlFoto;

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animationLogo = Tween<double>(begin: 0, end: 150)
        .animate(animationController)
      ..addListener(() => update());
    animationController.forward();
    showResources();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  showResources() async {
    _loading = true;
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("recursos")
        .get()
        .then((recursos) {
      _loading = false;
      _tagline = recursos["tagline"];
      _urlFoto = recursos["url"];
    });
  }

  void goToRegisterPage() async {
    Get.toNamed(AppRoutes.REGISTERMODE);
  }

  void goToLoginPage() async {
    Get.toNamed(AppRoutes.LOGIN);
  }
}
