import 'package:get/get.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToAdminMenu() async {
    Get.toNamed(AppRoutes.ADMINMENU);
  }

  void goToClientMenu() async {
    Get.toNamed(AppRoutes.CLIENTMENU);
  }
}
