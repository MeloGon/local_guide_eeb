import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class AddDetailsLocalController extends GetxController {
  double? _price;
  double? get price => _price;
  set priceSet(double value) {
    _price = value;
  }

  late TextEditingController txMenu;
  late TextEditingController txWeb;
  late TextEditingController txDelivery;

  @override
  void onInit() {
    txMenu = TextEditingController();
    txWeb = TextEditingController();
    txDelivery = TextEditingController();
    _setArguments();
    super.onInit();
  }

  _setArguments() {}

  onChangePrice(double value) {
    _price = value;
    update();
  }

  void goToAddTableReservePage() async {
    Get.toNamed(AppRoutes.ADDTABLERESERVE, arguments: [
      _price ?? 0,
      txMenu.text,
      txWeb.text,
      txDelivery.text,
    ]);
  }
}
