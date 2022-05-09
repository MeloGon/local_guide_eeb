import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals_guide_eeb/data/models/categorie.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class AddDetailsLocalController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Category> categoriasForDropDown = [];

  Category? _categorySelected;
  Category? get categorySelected => _categorySelected;

  double? _price;
  double? get price => _price;
  set priceSet(double value) {
    _price = value;
  }

  late TextEditingController txMenu;
  late TextEditingController txWeb;
  late TextEditingController txDelivery;

  //parametros que llegan
  String? _idSucursal;
  String? idLocal;
  String? _nameLocal;
  XFile? _photoLocal;
  XFile? get photoLocal => _photoLocal;
  String? _txAddress;
  String? _phoneNumber;
  String? _txPwd;
  String? _txRepeatPwd;
  String? _txNick;
  //--------------------

  LatLng? _marker;
  String? get nameLocal => _nameLocal;

  @override
  void onReady() {
    _chargeDataForDropDown();
    super.onReady();
  }

  @override
  void onInit() {
    txMenu = TextEditingController();
    txWeb = TextEditingController();
    txDelivery = TextEditingController();
    _setArguments();
    super.onInit();
  }

  _chargeDataForDropDown() async {
    categoriasForDropDown.clear();
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Categorias")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        final category =
            Category.fromDocumentSnapshot(documentSnapshot: element);
        categoriasForDropDown.add(category);
        update();
      });
    });
  }

  onChangedDDB(Category categoria) {
    _categorySelected = categoria;
    update();
  }

  _setArguments() {
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
  }

  onChangePrice(double value) {
    _price = value;
    update();
  }

  void goToAddTableReservePage() async {
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
      txMenu.text,
      txWeb.text,
      txDelivery.text,
    ]);
  }
}
