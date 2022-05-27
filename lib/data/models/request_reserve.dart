import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locals_guide_eeb/data/models/sucursal.dart';

class RequestReserve {
  String? idReserva;
  late String nombreUsuario;
  late int mesa;
  late String hora;
  late String fecha;
  late String obs;
  late String idMesa;
  late String idUsuario;

  RequestReserve({
    required this.idReserva,
    required this.nombreUsuario,
    required this.mesa,
    required this.hora,
    required this.fecha,
    required this.obs,
    required this.idMesa,
    required this.idUsuario,
  });

  RequestReserve.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    idReserva = documentSnapshot['idReserva'];
    nombreUsuario = documentSnapshot['nombreUsuario'];
    mesa = documentSnapshot['mesa'];
    hora = documentSnapshot['hora'];
    fecha = documentSnapshot['fecha'];
    obs = documentSnapshot['observaciones'];
    idMesa = documentSnapshot['mesaid'];
    idUsuario = documentSnapshot['idUsuario'];
  }
}
