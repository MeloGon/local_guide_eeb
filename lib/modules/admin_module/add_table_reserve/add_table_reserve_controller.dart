import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_table_reserve/local_widgets/dynamic_widget.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:random_string/random_string.dart';

import '../../../data/models/categorie.dart';

class AddTableReserveController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final cloudinary = CloudinaryPublic('en-el-blanco', 'o2pugvho', cache: false);

  List<dynamicWidget> dynamicList = [];

  late TextEditingController txAforo;

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
  //--------------------
  String? _flujo;

  String? _photoLocalUrl;

  @override
  void onReady() {
    if (_flujo == 'editar') {
      //metodo para mostrar el valor de las mesas
    }
    super.onReady();
  }

  @override
  void onInit() {
    txAforo = TextEditingController();
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

  addNewTable() {
    if (_table!.length != 0) {
      _table = [];
      dynamicList = [];
    }
    update();
    if (dynamicList.length >= 10) {
      return;
    }
    dynamicList.add(dynamicWidget(
      numeroMesa: dynamicList.length,
    ));
  }

  sendNewLocalData() async {
    dynamicList
        .forEach((widget) => _table!.add(widget.capacityController.text));

    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .set({
      'idSucursal': _idSucursal,
      'ubicacionLocal': _txAddress,
      'telefonoLocal': _phoneNumber,
      'username': _txNick,
      'pwdLocal': _txPwd,
      'repeatPwd': _txPwd,
      'categoria': _category?.nombre ??
          'ca', // esta parte la categoria ya se debio haber eliminado, confirmar
      'precioLocal': _price,
      'linkLocal': _txMenu,
      'linkWeb': _txWeb,
      'linkDelivery': _txDelivery,
      'marker': _marker.toString(),
      'aforo': txAforo.text,
      //falta aqui as mesas
    });

    //para agregar las mesas

    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .get()
        .then((sucursalDoc) {
      dynamicList.forEach((mesas) {
        var idMesaTemp = (randomAlphaNumeric(8));
        sucursalDoc.reference.collection("Mesas").doc(idMesaTemp).set({
          'idMesa': idMesaTemp,
          'reservado': false,
          'asientos': mesas.capacityController.text,
          'nroMesa': dynamicList.indexOf(mesas) + 1,
        });
      });
    });

    //----------------------------------------
    Get.offAllNamed(AppRoutes.ADMINMENU);
    Get.snackbar('El local ha sido agregado',
        'Puedes asegurarte ingresando a la opcion de locales para poder visualizarlo.',
        colorText: MyColors.blackBg, backgroundColor: MyColors.white);
  }

  addNewAddress() async {
    dynamicList
        .forEach((widget) => _table!.add(widget.capacityController.text));

    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .set({
      'idSucursal': _idSucursal,
      'ubicacionLocal': _txAddress,
      'telefonoLocal': _phoneNumber,
      'username': _txNick,
      'pwdLocal': _txPwd,
      'repeatPwd': _txPwd,
      'categoria': _category!.nombre,
      'precioLocal': _price,
      'linkLocal': _txMenu,
      'linkWeb': _txWeb,
      'linkDelivery': _txDelivery,
      'marker': _marker.toString(),
      //falta aqui as mesas
    });
    Get.offAllNamed(AppRoutes.ADDADDRESS, arguments: [
      idLocal,
      _nameLocal,
      _photoLocal,
      '',
      '',
    ]);
    Get.snackbar('Sucursal agregada',
        'La sucursar ha sido agregada, podras ver los cambios cuando termines de agregar la nueva sucursal',
        colorText: MyColors.blackBg, backgroundColor: MyColors.white);
  }
}
