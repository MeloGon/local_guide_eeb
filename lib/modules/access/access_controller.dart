import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class AccessController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animationLogo;

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
    super.onInit();
  }

  void goToRegisterPage() async {
    Get.toNamed(AppRoutes.REGISTERMODE);
  }

  void goToLoginPage() async {
    Get.toNamed(AppRoutes.LOGIN);
  }
}
