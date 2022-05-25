import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locals_guide_eeb/data/models/sucursal.dart';

class Mesa {
  String? idMesa;
  late String asientos;
  late int nroMesa;
  late bool reservado;

  Mesa({
    required this.idMesa,
    required this.asientos,
    required this.nroMesa,
    required this.reservado,
  });

  Mesa.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    idMesa = documentSnapshot['idMesa'];
    asientos = documentSnapshot['asientos'];
    nroMesa = documentSnapshot['nroMesa'];
    reservado = documentSnapshot['reservado'];
  }
}
