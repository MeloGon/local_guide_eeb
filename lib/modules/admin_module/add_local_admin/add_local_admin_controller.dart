import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals_guide_eeb/data/models/categorie.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/widgets/dialogs/dialog_two_buttons.dart';
import 'package:random_string/random_string.dart';

class AddLocalAdminController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final cloudinary = CloudinaryPublic('en-el-blanco', 'o2pugvho', cache: false);
  XFile? _fotoLocal;
  XFile? get fotoLocal => _fotoLocal;
  late TextEditingController txNameLocal;
  late String idLocal;
  String? _flujo;
  CloudinaryResponse? response;

  List<Category> categoriasForDropDown = [];

  Category? _categorySelected;
  Category? get categorySelected => _categorySelected;

  @override
  void onReady() {
    _chargeDataForDropDown();
    super.onReady();
  }

  @override
  void onInit() {
    txNameLocal = TextEditingController();
    idLocal = (randomAlphaNumeric(8));
    super.onInit();
  }

  _chargeDataForDropDown() async {
    categoriasForDropDown.clear();
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Categorias")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        final category =
            Category.fromDocumentSnapshot(documentSnapshot: element);
        categoriasForDropDown.add(category);
        update();
      });
    });
  }

  onChangedDDB(Category categoria) {
    _categorySelected = categoria;
    update();
  }

  void goToAddAddressPage() async {
    if (_fotoLocal == null || txNameLocal.text.isEmpty) {
      Get.snackbar('Advertencia', 'Para continuar llena todos los campos',
          backgroundColor: MyColors.white);
    } else {
      try {
        response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(_fotoLocal!.path,
              resourceType: CloudinaryResourceType.Image),
        );
        print(response!.secureUrl);
      } on CloudinaryException catch (e) {
        print(e.message);
        print(e.request);
      }
      await firebaseFirestore
          .collection("GuiaLocales")
          .doc("admin")
          .collection("Locales")
          .doc(idLocal)
          .set({
        'idLocal': idLocal,
        'nombreLocal': txNameLocal.text,
        'fotoLocal': response!.secureUrl,
        'categoria': _categorySelected!.nombre,
        'colorCategoria': _categorySelected!.color,
      });
      Get.snackbar('Información',
          'El local ha sido creado, procede a añadir la sucursal',
          backgroundColor: MyColors.white);
      Get.toNamed(AppRoutes.ADDADDRESS, arguments: [
        idLocal,
        txNameLocal.text,
        _fotoLocal,
      ]);
    }
  }

  addPhoto() async {
    Get.dialog(
        DialogTwoButtons(
          title: 'Imagen de perfil',
          content: 'Selecciona una opcion para agregar la imagen',
          textButton1: 'Abrir la galeria',
          textButton2: 'Tomar una fotografía',
          isDismissible: true,
          onTap: () async {
            _fotoLocal =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            update();
            Get.back();
            //linkToCloudinary(_fotoLocal!);
          },
          onTap2: () async {
            _fotoLocal =
                await ImagePicker().pickImage(source: ImageSource.camera);
            update();
            Get.back();
            //linkToCloudinary(_fotoLocal!);
          },
        ),
        barrierDismissible: true);
  }

  // linkToCloudinary(XFile? photo) async {
  //   try {
  //     CloudinaryResponse response = await cloudinary.uploadFile(
  //       CloudinaryFile.fromFile(photo!.path,
  //           resourceType: CloudinaryResourceType.Image),
  //     );
  //     print(response.secureUrl);
  //   } on CloudinaryException catch (e) {
  //     print(e.message);
  //     print(e.request);
  //   }
  // }
}
