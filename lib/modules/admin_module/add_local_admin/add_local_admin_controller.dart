import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class AddLocalAdminController extends GetxController {
  final cloudinary = CloudinaryPublic('en-el-blanco', 'o2pugvho', cache: false);
  XFile? _fotoLocal;
  XFile? get fotoLocal => _fotoLocal;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToAddAddressPage() async {
    Get.toNamed(AppRoutes.ADDADDRESS);
  }

  addPhoto() async {
    //_fotoLocal = await ImagePicker().pickImage(source: ImageSource.camera);

    /*  try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(_fotoLocal!.path,
            resourceType: CloudinaryResourceType.Image),
      );

      print(response.secureUrl);
    } on CloudinaryException catch (e) {
      print(e.message);
      print(e.request);
    } */
  }
}
