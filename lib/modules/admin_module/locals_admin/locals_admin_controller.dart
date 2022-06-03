import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/data/models/local.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class LocalsAdminController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Local> locales = [];
  bool _loading = false;
  bool get loading => _loading;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    showLocals();
    super.onReady();
  }

  void goToAddLocalAdminPage() async {
    Get.toNamed(AppRoutes.ADDLOCALADMIN);
  }

  void showLocals() async {
    locales.clear();
    _loading = true;
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        final local = Local.fromDocumentSnapshot(documentSnapshot: element);
        locales.add(local);
        update();
      });
    }).then((value) {
      _loading = false;
      update();
    });
  }

  void goToSucursales(
      String? idLocal, String? nameLocal, String? fotoLocal) async {
    Get.toNamed(AppRoutes.SUCURSALADMIN, arguments: [
      idLocal,
      nameLocal,
      fotoLocal,
    ]);
  }
}
