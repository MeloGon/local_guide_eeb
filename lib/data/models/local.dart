import 'package:cloud_firestore/cloud_firestore.dart';

class Local {
  String? idLocal;
  late String nombreLocal;
  late String fotoLocal;
  late String ubicacionLocal;
  late String telefonoLocal;
  late String pwdLocal;
  late String linkLocal;
  late String linkWeb;
  late String linkDelivery;

  Local({
    required this.idLocal,
    required this.nombreLocal,
    required this.fotoLocal,
    required this.ubicacionLocal,
    required this.telefonoLocal,
    required this.pwdLocal,
    required this.linkLocal,
    required this.linkWeb,
    required this.linkDelivery,
  });

  Local.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    idLocal = documentSnapshot['idLocal'];
    nombreLocal = documentSnapshot['nombreLocal'];
    fotoLocal = documentSnapshot['fotoLocal'];
    ubicacionLocal = documentSnapshot['ubicacionLocal'];
    telefonoLocal = documentSnapshot['telefonoLocal'];
    pwdLocal = documentSnapshot['pwdLocal'];
    linkLocal = documentSnapshot['linkLocal'];
    linkWeb = documentSnapshot['linkWeb'];
    linkDelivery = documentSnapshot['linkDelivery'];
  }
}
