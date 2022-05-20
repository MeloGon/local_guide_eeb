import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locals_guide_eeb/data/models/sucursal.dart';

class Marcador {
  String? nombreLocal;
  late Sucursal sucursal;

  Marcador({
    required this.nombreLocal,
    required this.sucursal,
  });
}
