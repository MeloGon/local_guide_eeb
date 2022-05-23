import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/data/models/categorie.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:permission_handler/permission_handler.dart';

class UserMenuController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Category> categorias = [];

  double? _distance;
  double? get distance => _distance;
  set distanceSet(double value) {
    _distance = value;
  }

  @override
  void onReady() {
    showCategories();
    //getPermission();
    super.onReady();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void showCategories() async {
    categorias.clear();
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Categorias")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        final category =
            Category.fromDocumentSnapshot(documentSnapshot: element);
        categorias.add(category);
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
    Get.toNamed(AppRoutes.USERMAPS);
  }
}
