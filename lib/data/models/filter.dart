import 'package:cloud_firestore/cloud_firestore.dart';

class Filter {
  String? idCategory;
  late String nombre;
  late String color;
  bool isSelected = false;

  Filter({
    required this.idCategory,
    required this.nombre,
    required this.color,
    required this.isSelected,
  });
}
