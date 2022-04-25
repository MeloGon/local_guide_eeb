import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String? idCategory;
  late String nombre;
  late String color;

  Category({
    required this.idCategory,
    required this.nombre,
    required this.color,
  });

  Category.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    idCategory = documentSnapshot.id;
    nombre = documentSnapshot["nombre"];
    color = documentSnapshot["color"];
  }
}
