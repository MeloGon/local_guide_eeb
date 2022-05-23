import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locals_guide_eeb/data/models/sucursal.dart';

class LocalUbication {
  late Sucursal sucursal;
  late double distance;

  LocalUbication({
    required this.sucursal,
    required this.distance,
  });
}
