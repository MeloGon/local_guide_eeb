import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locals_guide_eeb/data/models/categorie.dart';

class Admin {
  String? idAdmin;
  late List<Category> categories;

  Admin({
    required this.idAdmin,
    required this.categories,
  });

  Admin.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    idAdmin = documentSnapshot.id;
    categories = documentSnapshot["categorias"];
  }
}
