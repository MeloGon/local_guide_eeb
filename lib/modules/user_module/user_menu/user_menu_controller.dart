import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:locals_guide_eeb/data/models/categorie.dart';
import 'package:locals_guide_eeb/data/models/filter.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:permission_handler/permission_handler.dart';

class UserMenuController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Filter>? _categorias = [];
  List<Filter>? get categorias => _categorias;

  List<Filter>? _categoriasSelected = [];
  List<Filter>? get categoriasSelected => _categoriasSelected;

  double? _distance;
  double? get distance => _distance;
  set distanceSet(double value) {
    _distance = value;
  }

  //parametros que llegan
  String? _idUser, _displayName, _photoUrl;
  int? _tipoUsuario;
  //--------------------

  late GroupButtonController groupButtonController;

  @override
  void onReady() {
    showCategories();
    //getPermission();
    super.onReady();
  }

  @override
  void onInit() {
    _distance = 15;
    groupButtonController = GroupButtonController();
    setArguments();
    super.onInit();
  }

  setArguments() {
    _idUser = Get.arguments[0] as String;
    _displayName = Get.arguments[1] as String;
    _photoUrl = Get.arguments[2] as String;
    _tipoUsuario = Get.arguments[3] as int;
  }

  void showCategories() async {
    _categorias!.clear();
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Categorias")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        final category =
            Category.fromDocumentSnapshot(documentSnapshot: element);
        _categorias!.add(Filter(
            idCategory: category.idCategory,
            nombre: category.nombre,
            color: category.color,
            isSelected: false));
        update();
      });
    });
  }

  getPermission() async {
    if (await Permission.location.request().isGranted) {
      print('permiso concedido');
    }
  }

  onChangeDistance(double value) {
    _distance = value;
    update();
  }

  hideFilter() async {
    /* categoriasSelected!.forEach((element) {
      print('nombre de la categoria ${element.nombre}');
    }); */
    Get.toNamed(AppRoutes.USERMAPS, arguments: [
      _categoriasSelected,
      _idUser,
      _displayName,
      _photoUrl,
      _tipoUsuario,
      _distance,
    ]);
  }

  onChanged(Filter value) {
    value.isSelected = !value.isSelected;
    if (value.isSelected) {
      _categoriasSelected!.add(value);
    } else {
      _categoriasSelected!.remove(value);
    }
    update();
  }
}
