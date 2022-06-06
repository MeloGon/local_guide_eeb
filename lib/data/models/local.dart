import 'package:cloud_firestore/cloud_firestore.dart';

class Local {
  String? idLocal;
  late String nombreLocal;
  late String fotoLocal;
  late String categoria;
  late String colorCategoria;
  late int tipoUsuario;

  Local({
    required this.idLocal,
    required this.nombreLocal,
    required this.fotoLocal,
    required this.categoria,
    required this.colorCategoria,
    required this.tipoUsuario,
  });

  Local.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    idLocal = documentSnapshot['idLocal'];
    nombreLocal = documentSnapshot['nombreLocal'];
    fotoLocal = documentSnapshot['fotoLocal'];
    categoria = documentSnapshot['categoria'];
    colorCategoria = documentSnapshot['colorCategoria'];
    tipoUsuario = documentSnapshot['tipoUsuario'];
  }
}
