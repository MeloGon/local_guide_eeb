import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locals_guide_eeb/data/models/sucursal.dart';

class LocalBottom {
  String? nombreLocal;
  String? colorCategoria;
  String? categoria;
  Sucursal? sucursal;
  double? distance;
  String? fotoLocal;
  String? idLocal;

  LocalBottom({
    required this.nombreLocal,
    required this.colorCategoria,
    required this.categoria,
    required this.sucursal,
    required this.distance,
    required this.fotoLocal,
    required this.idLocal,
  });
}
