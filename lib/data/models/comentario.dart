import 'package:cloud_firestore/cloud_firestore.dart';

class Comentario {
  String? idComentario;
  late String fotoUsuario;
  late String nombreUsuario;
  late String post;
  late String fechaComentario;
  late int likes;

  Comentario({
    required this.idComentario,
    required this.fotoUsuario,
    required this.nombreUsuario,
    required this.post,
    required this.fechaComentario,
    required this.likes,
  });

  Comentario.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    idComentario = documentSnapshot['idComentario'];
    fotoUsuario = documentSnapshot['fotoUsuario'];
    nombreUsuario = documentSnapshot['nombreUsuario'];
    post = documentSnapshot['post'];
    likes = documentSnapshot['likes'];
  }
}