import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:locals_guide_eeb/data/models/foto.dart';

class PhotoLike {
  late Foto foto;
  late var liked;

  PhotoLike({
    required this.foto,
    required this.liked,
  });
}
