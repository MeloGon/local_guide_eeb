import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_table_reserve/local_widgets/dynamic_widget.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';

class AddTableReserveController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final cloudinary = CloudinaryPublic('en-el-blanco', 'o2pugvho', cache: false);

  List<dynamicWidget> dynamicList = [];

  List<String>? _table = [];
  List<String>? get table => _table;

  //parametros que llegan
  String? idLocal;
  String? _nameLocal;
  XFile? _photoLocal;
  String? _txAddress;
  String? _phoneNumber;
  String? _txPwd;
  String? _txRepeatPwd;
  double? _price;
  String? _txMenu;
  String? _txWeb;
  String? _txDelivery;
  //--------------------

  String? _photoLocalUrl;

  @override
  void onInit() {
    setArguments();
    super.onInit();
  }

  setArguments() {
    idLocal = Get.arguments[0] as String;
    _nameLocal = Get.arguments[1] as String;
    _photoLocal = Get.arguments[2] as XFile;
    _txAddress = Get.arguments[3] as String;
    _phoneNumber = Get.arguments[4] as String;
    _txPwd = Get.arguments[5] as String;
    _txRepeatPwd = Get.arguments[6] as String;
    _price = Get.arguments[7] as double;
    _txMenu = Get.arguments[8] as String;
    _txWeb = Get.arguments[9] as String;
    _txDelivery = Get.arguments[10] as String;
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

    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(_photoLocal!.path,
            resourceType: CloudinaryResourceType.Image),
      );
      _photoLocalUrl = response.secureUrl;
      print(response.secureUrl);
    } on CloudinaryException catch (e) {
      print(e.message);
      print(e.request);
    }

    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(idLocal)
        .set({
      'idLocal': idLocal,
      'nombreLocal': _nameLocal,
      'fotoLocal': _photoLocalUrl,
      'ubicacionLocal': _txAddress,
      'telefonoLocal': _phoneNumber,
      'pwdLocal': _txPwd,
      'repeatPwd': _txPwd,
      'categoria': 'Alguna categoria',
      'precioLocal': _price,
      'linkLocal': _txMenu,
      'linkWeb': _txWeb,
      'linkDelivery': _txDelivery,

      //falta aqui as mesas
    });
    Get.offAllNamed(AppRoutes.ADMINMENU);
    Get.snackbar('El local ha sido agregado',
        'Puedes asegurarte ingresando a la opcion de locales para poder visualizarlo.',
        colorText: MyColors.blackBg, backgroundColor: MyColors.white);
  }
}
