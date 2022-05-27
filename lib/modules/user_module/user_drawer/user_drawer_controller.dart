import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class UserDrawerController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  goToHomeUser() async {
    Get.toNamed(AppRoutes.USERHOME);
  }

  signOut() async {
    await GoogleSignIn().signOut();
    Get.offAllNamed(AppRoutes.ACCESS);
  }
}
