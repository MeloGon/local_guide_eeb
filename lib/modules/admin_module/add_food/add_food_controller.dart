import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals_guide_eeb/data/models/categorie.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_food/local_widgets/food_field_widget.dart';

class AddFoodController extends GetxController {
  List<foodFieldWidget> dynamicList = [];

  List<String>? _table = [];
  List<String>? get table => _table;

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
    if (_table!.length != 0) {
      _table = [];
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
}
