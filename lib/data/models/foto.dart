import 'package:cloud_firestore/cloud_firestore.dart';

class Foto {
  String? idFoto;
  late String likes;
  late String pathFoto;

  Foto({
    required this.idFoto,
    required this.likes,
    required this.pathFoto,
  });

  Foto.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    idFoto = documentSnapshot['idFoto'];
    likes = documentSnapshot['likes'];
    pathFoto = documentSnapshot['pathFoto'];
  }
}
