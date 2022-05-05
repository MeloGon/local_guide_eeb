import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locals_guide_eeb/data/models/sucursal.dart';

class Local {
  String? idLocal;
  late String nombreLocal;
  late String fotoLocal;

  Local({
    required this.idLocal,
    required this.nombreLocal,
    required this.fotoLocal,
  });

  Local.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    idLocal = documentSnapshot['idLocal'];
    nombreLocal = documentSnapshot['nombreLocal'];
    fotoLocal = documentSnapshot['fotoLocal'];
  }
}
