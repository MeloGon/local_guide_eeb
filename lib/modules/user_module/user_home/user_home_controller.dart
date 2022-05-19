import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class UserHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  TabController? _tabController;
  TabController? get tabController => _tabController;
  int? _indexTab;
  int? get indexTab => _indexTab;
  //para las fotos del tab de momentos
  XFile? _fotoMomentos;
  XFile? get fotoMomentos => _fotoMomentos;
  CloudinaryResponse? response;
  final cloudinary = CloudinaryPublic('en-el-blanco', 'o2pugvho', cache: false);
  QuerySnapshot? localesQuery;
  //-----------------------------------

  @override
  void onReady() {
    _tabController!.addListener(cambiandoTabs);
    super.onReady();
  }

  @override
  void onInit() {
    _tabController = TabController(length: 3, vsync: this);
    super.onInit();
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

    /* if (_fotoMomentos != null) {
      var idFotoTemp = (randomAlphaNumeric(8));
      try {
        response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(_fotoMomentos!.path,
              resourceType: CloudinaryResourceType.Image),
        );
        await firebaseFirestore
            .collection("GuiaLocales")
            .doc("admin")
            .collection("Locales")
            .doc(_idLocal)
            .get()
            .then((local) {
          local.reference
              .collection("Sucursales")
              .doc(_idSucursal)
              .get()
              .then((sucursal) {
            sucursal.reference.collection("Fotografias").doc(idFotoTemp).set({
              'idFoto': idFotoTemp,
              'likes': '0',
              'pathFoto': response!.secureUrl
            });

            //------------------------------------------
          });
        });
      } on CloudinaryException catch (e) {
        print(e.message);
        print(e.request);
      }
    } */
  }
  //---------------------------------------------------------------------------

}
