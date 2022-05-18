import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? idUser;
  late String nombreUser;
  late String photoUser;

  User({
    required this.idUser,
    //required this.nombreUser,
    required this.photoUser,
  });

  User.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    idUser = documentSnapshot['idUser'];
    nombreUser = documentSnapshot['nombreUser'];
    photoUser = documentSnapshot['photoUser'];
  }
}
