import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locals_guide_eeb/data/models/comentario.dart';

class CommentLike {
  late Comentario comentario;
  late var liked;

  CommentLike({
    required this.comentario,
    required this.liked,
  });
}
