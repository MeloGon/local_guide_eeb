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

  void goToUsersAdminPage() async {
    Get.toNamed(AppRoutes.USERSADMIN);
  }

  void goToActivityAdminPage() async {
    Get.toNamed(AppRoutes.ACTIVITYADMIN);
  }

  void goToInfoAdminPage() async {
    Get.toNamed(AppRoutes.INFOADMIN);
  }

  void logout() async {
    Get.offAllNamed(AppRoutes.ACCESS);
  }
}
