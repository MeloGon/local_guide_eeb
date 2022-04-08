import 'package:get/get.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class AccessController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToRegisterPage() async {
    Get.toNamed(AppRoutes.REGISTERMODE);
  }

  void goToLoginPage() async {
    Get.toNamed(AppRoutes.LOGIN);
  }
}
