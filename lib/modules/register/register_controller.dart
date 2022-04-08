import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class RegisterController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToRegisterByPhone() async {
    Get.toNamed(AppRoutes.REGISTERPHONE);
  }
}
