import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals_guide_eeb/data/models/comentario.dart';
import 'package:locals_guide_eeb/data/models/comment_like.dart';
import 'package:locals_guide_eeb/data/models/request_reserve.dart';
import 'package:locals_guide_eeb/data/models/reserve_home_user.dart';
import 'package:random_string/random_string.dart';

import '../../../data/models/foto.dart';

class UserHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  TabController? _tabController;
  TabController? get tabController => _tabController;
  int? _indexTab;
  int? get indexTab => _indexTab;
  //para las fotos del tab de momentos
  List<Foto>? _listFoto = [];
  List<Foto>? get listFoto => _listFoto;
  XFile? _fotoMomentos;
  XFile? get fotoMomentos => _fotoMomentos;
  CloudinaryResponse? response;
  final cloudinary = CloudinaryPublic('en-el-blanco', 'o2pugvho', cache: false);
  QuerySnapshot? localesQuery;
  //-----------------------------------

  //parametros que llegan
  String? _idUser, _displayName, _photoUrl;
  String? get displayName => _displayName;
  String? get photoUrl => _photoUrl;
  //------------------------------------

  //para los comentarios
  int? _tipoUsuario;
  int? get tipoUsuario => _tipoUsuario;
  late TextEditingController txPost;
  List<CommentLike>? _listComentarios = [];
  List<CommentLike>? get listComentarios => _listComentarios;
  bool? _darLike = true;
  bool? get darLike => _darLike;
  //--------------------------------------

  //para las reservas
  List<ReserveForUser>? _listaReservas = [];
  List<ReserveForUser>? get listaReservas => _listaReservas;
  //--------------------------------------

  @override
  void onReady() {
    _tabController!.addListener(cambiandoTabs);
    loadComments();
    loadReservas();
    super.onReady();
  }

  @override
  void onInit() {
    _tabController = TabController(length: 3, vsync: this);
    setArguments();
    super.onInit();
  }

  setArguments() {
    _idUser = Get.arguments[0];
    _displayName = Get.arguments[1];
    _photoUrl = Get.arguments[2] as String;
  }

  cambiandoTabs() {
    _indexTab = _tabController!.index;
    update();
  }

  //metodos para subir foto en el tab de momentos
  addMoment({String? option}) async {
    switch (option) {
      case "camara":
        _fotoMomentos =
            await ImagePicker().pickImage(source: ImageSource.camera);
        update();
        break;
      case "galeria":
        _fotoMomentos =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        update();
        break;
    }

    if (_fotoMomentos != null) {
      var idFotoTemp = (randomAlphaNumeric(8));
      try {
        response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(_fotoMomentos!.path,
              resourceType: CloudinaryResourceType.Image),
        );
        // DESCOMENTAR Y ACOMODAR PARA SUBIR EL MOMENTO PARA EL USUARIO
        // await firebaseFirestore
        //     .collection("GuiaLocales")
        //     .doc("admin")
        //     .collection("Usuarios")
        //     .doc(_idUser)
        //     .get()
        //     .then((user) {
        //   user.reference
        //       .collection("Fotografias")
        //       .doc(_idFoto)
        //       .set();

        //     //------------------------------------------
        //   });
        // });
      } on CloudinaryException catch (e) {
        print(e.message);
        print(e.request);
      }
    }
  }
  //---------------------------------------------------------------------------

  loadComments() async {
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .get()
        .then((docsLocales) {
      for (var local in docsLocales.docs) {
        local.reference.collection("Sucursales").get().then((docsSucursales) {
          for (var sucursal in docsSucursales.docs) {
            sucursal.reference
                .collection("Comentarios")
                .get()
                .then((docsComentarios) async {
              for (var comentario in docsComentarios.docs) {
                if (_idUser == comentario["idUsuario"]) {
                  final comment = Comentario.fromDocumentSnapshot(
                      documentSnapshot: comentario);
                  _listComentarios!
                      .add(CommentLike(comentario: comment, liked: true));
                  update();
                }
              }
            });
          }
        });
      }
    });
  }

  loadReservas() async {
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .get()
        .then((docsLocales) {
      for (var local in docsLocales.docs) {
        local.reference.collection("Sucursales").get().then((docsSucursales) {
          for (var sucursal in docsSucursales.docs) {
            sucursal.reference
                .collection("Reservas")
                .get()
                .then((docsReservas) async {
              for (var reserva in docsReservas.docs) {
                if (_idUser == reserva["idUsuario"]) {
                  final reqReserve = RequestReserve.fromDocumentSnapshot(
                      documentSnapshot: reserva);
                  _listaReservas!.add(ReserveForUser(
                      reserva: reqReserve,
                      nombre: local["nombreLocal"],
                      categoria: local["categoria"],
                      colorCategoria: local["colorCategoria"]));

                  update();
                }
              }
            });
          }
        });
      }
    });
  }
}
