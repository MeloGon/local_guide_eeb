import 'package:get/get.dart';
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
}
