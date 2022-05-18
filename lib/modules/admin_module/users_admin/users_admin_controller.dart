import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:locals_guide_eeb/data/models/user.dart';

class UsersAdminController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<User> usuarios = [];

  @override
  void onReady() {
    showUsers();
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
  }

  void showUsers() async {
    usuarios.clear();
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Usuarios")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.data());
        final user = User.fromDocumentSnapshot(documentSnapshot: element);
        usuarios.add(user);
        update();
      });
    });
  }
}
