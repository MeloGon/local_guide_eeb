import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class AdminMenuController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToLocalsAdminPage() async {
    Get.toNamed(AppRoutes.LOCALSADMIN);
  }
}
