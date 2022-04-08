import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class RegisterPhoneController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToOtp() async {
    Get.toNamed(AppRoutes.OTP);
  }
}
