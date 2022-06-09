import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locals_guide_eeb/data/models/request_reserve.dart';

class ReserveForUser {
  late RequestReserve reserva;
  late String nombre;
  late String categoria;
  late String colorCategoria;

  ReserveForUser({
    required this.reserva,
    required this.nombre,
    required this.categoria,
    required this.colorCategoria,
  });
}
