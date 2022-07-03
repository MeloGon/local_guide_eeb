import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    Get.toNamed(AppRoutes.ADDCATEGORIEADMIN, arguments: ['agregar']);
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

  goToEditCategorie(Category categoria) async {
    Get.toNamed(AppRoutes.ADDCATEGORIEADMIN, arguments: [
      'editar',
      categoria.idCategory,
    ]);
  }

  deleteCategory(String? idCategory) async {
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Categorias")
        .doc(idCategory)
        .delete()
        .then((value) {
      Get.snackbar('Información', 'La categoria ha sido eliminada con éxito',
          colorText: Colors.black, backgroundColor: Colors.white);
      showCategories();
    });
  }
}
