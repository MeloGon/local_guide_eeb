import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/data/models/categorie.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class CategoriesAdminController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Category> categorias = [];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    showCategories();
    super.onReady();
  }

  void goToAddCategorieAdminPage() async {
    Get.toNamed(AppRoutes.ADDCATEGORIEADMIN);
  }

  void showCategories() async {
    // await firebaseFirestore
    //     .collection("GuiaLocales")
    //     .doc("admin")
    //     .collection("Categorias")
    //     .snapshots()
    //     .map((event) {
    //   for (var item in event.docs) {
    //     print(item);
    //     final category = Category.fromDocumentSnapshot(documentSnapshot: item);
    //     categorias.add(category);
    //     update();
    //   }
    //   return categorias;
    // });
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
}
