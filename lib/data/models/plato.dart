import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locals_guide_eeb/data/models/sucursal.dart';

class Plato {
  String? idPlato;
  late String nombrePlato;

  Plato({
    required this.idPlato,
    required this.nombrePlato,
  });

  Plato.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    idPlato = documentSnapshot['idPlato'];
    nombrePlato = documentSnapshot['nombrePlato'];
  }
}
