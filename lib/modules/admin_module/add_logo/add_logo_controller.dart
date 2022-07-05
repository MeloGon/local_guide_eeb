import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:locals_guide_eeb/widgets/dialogs/dialog_two_buttons.dart';

class AddLogoController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final cloudinary = CloudinaryPublic('en-el-blanco', 'o2pugvho', cache: false);
  CloudinaryResponse? response;
  XFile? _fotoLocal;
  XFile? get fotoLocal => _fotoLocal;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  addPhoto() async {
    Get.dialog(
        DialogTwoButtons(
          title: 'Cambiar el logo del app',
          content: 'Selecciona una opcion para agregar la imagen',
          textButton1: 'Abrir la galeria',
          textButton2: 'Tomar una fotografía',
          isDismissible: true,
          onTap: () async {
            _fotoLocal = await ImagePicker().pickImage(
                source: ImageSource.gallery,
                imageQuality: 70,
                maxWidth: 1024,
                maxHeight: 768);
            update();
            Get.back();
            //linkToCloudinary(_fotoLocal!);
          },
          onTap2: () async {
            _fotoLocal = await ImagePicker().pickImage(
                source: ImageSource.camera,
                imageQuality: 70,
                maxWidth: 1024,
                maxHeight: 768);
            update();
            Get.back();
            //linkToCloudinary(_fotoLocal!);
          },
        ),
        barrierDismissible: true);
  }

  saveChanges() async {
    if (_fotoLocal == null) {
      Get.snackbar('Advertencia', 'Para continuar selecciona la foto',
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
      await firebaseFirestore.collection("GuiaLocales").doc("recursos").update({
        "url": response!.secureUrl,
      }).then((value) {
        Get.snackbar(
            'Información', 'El logo del aplicativo ha sido cambiado con éxito',
            backgroundColor: MyColors.white);
        Get.offAllNamed(AppRoutes.ADMINMENU);
      });
    }
  }
}


//https://res.cloudinary.com/en-el-blanco/image/upload/v1654264381/parrilla_iq6tnh.png