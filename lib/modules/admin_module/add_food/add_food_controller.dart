import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals_guide_eeb/data/models/categorie.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_food/local_widgets/food_field_widget.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class AddFoodController extends GetxController {
  List<foodFieldWidget> dynamicList = [];

  List<String>? _foods = [];
  List<String>? get food => _foods;

  //parametros que llegan
  String? _idSucursal;
  LatLng? _marker;
  String? idLocal;
  String? _nameLocal;
  dynamic? _photoLocal;
  String? _txAddress;
  String? _phoneNumber;
  String? _txPwd;
  String? _txRepeatPwd;
  Category? _category;
  double? _price;
  String? _txMenu;
  String? _txWeb;
  String? _txDelivery;
  String? _txNick;
  String? _flujo;
  //--------------------

  Category? _categorySelected;
  Category? get categorySelected => _categorySelected;

  @override
  void onInit() {
    setArguments();
    super.onInit();
  }

  setArguments() {
    _idSucursal = Get.arguments[0] as String;
    _marker = Get.arguments[1] as LatLng;
    idLocal = Get.arguments[2] as String;
    _nameLocal = Get.arguments[3] as String;
    _photoLocal = Get.arguments[4];
    _txAddress = Get.arguments[5] as String;
    _phoneNumber = Get.arguments[6] as String;
    _txNick = Get.arguments[7] as String;
    _txPwd = Get.arguments[8] as String;
    _txRepeatPwd = Get.arguments[9] as String;
    _category = Get.arguments[10];
    _price = Get.arguments[11] as double;
    _txMenu = Get.arguments[12] as String;
    _txWeb = Get.arguments[13] as String;
    _txDelivery = Get.arguments[14] as String;
    _flujo = Get.arguments[15] as String;
  }

  addNewFood() {
    if (_foods!.length != 0) {
      _foods = [];
      dynamicList = [];
    }
    update();
    if (dynamicList.length >= 10) {
      return;
    }
    dynamicList.add(foodFieldWidget(
      numeroPlato: dynamicList.length,
    ));
  }

  void goToAddTableReservePage() async {
    for (var widget in dynamicList) {
      _foods!.add(widget.capacityController.text);
    }
    Get.toNamed(AppRoutes.ADDTABLERESERVE, arguments: [
      _idSucursal,
      _marker,
      idLocal,
      _nameLocal,
      _photoLocal,
      _txAddress,
      _phoneNumber,
      _txNick,
      _txPwd,
      _txRepeatPwd,
      _categorySelected,
      _price ?? 0,
      _txMenu,
      _txWeb,
      _txDelivery,
      _flujo,
      dynamicList,
    ]);
  }
}
