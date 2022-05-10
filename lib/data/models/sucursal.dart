import 'package:cloud_firestore/cloud_firestore.dart';

class Sucursal {
  String? idSucursal;
  late String ubicacionLocal;
  late String telefonoLocal;
  late String pwdLocal;
  late String linkLocal;
  late String linkWeb;
  late String linkDelivery;
  late String categoria;
  late String username;
  late double price;

  Sucursal({
    required this.idSucursal,
    required this.ubicacionLocal,
    required this.telefonoLocal,
    required this.pwdLocal,
    required this.linkLocal,
    required this.linkWeb,
    required this.linkDelivery,
    required this.categoria,
    required this.username,
    required this.price,
  });

  Sucursal.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    ubicacionLocal = documentSnapshot['ubicacionLocal'];
    telefonoLocal = documentSnapshot['telefonoLocal'];
    pwdLocal = documentSnapshot['pwdLocal'];
    linkLocal = documentSnapshot['linkLocal'];
    linkWeb = documentSnapshot['linkWeb'];
    linkDelivery = documentSnapshot['linkDelivery'];
    categoria = documentSnapshot['categoria'];
    username = documentSnapshot['username'];
    price = documentSnapshot['precioLocal'];
  }
}
