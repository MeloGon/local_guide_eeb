import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:locals_guide_eeb/widgets/dialogs/dialog_two_buttons.dart';
import 'package:random_string/random_string.dart';

class AddLocalAdminController extends GetxController {
  final cloudinary = CloudinaryPublic('en-el-blanco', 'o2pugvho', cache: false);
  XFile? _fotoLocal;
  XFile? get fotoLocal => _fotoLocal;
  late TextEditingController txNameLocal;
  late String idLocal;

  @override
  void onInit() {
    txNameLocal = TextEditingController();
    idLocal = (randomAlphaNumeric(8));
    super.onInit();
  }

  void goToAddAddressPage() async {
    Get.toNamed(AppRoutes.ADDADDRESS, arguments: [
      idLocal,
      txNameLocal.text,
      _fotoLocal,
    ]);
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
            //linkToCloudinary(_fotoLocal!);
          },
          onTap2: () async {
            _fotoLocal =
                await ImagePicker().pickImage(source: ImageSource.camera);
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
