import 'package:get/get.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class InfoAdminController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToChangeLogo() async {
    Get.toNamed(AppRoutes.ADDLOGO);
  }

  void goToCategoriesPage() async {
    Get.toNamed(AppRoutes.CATEGORIESADMIN);
  }

  void goToChangeTagline() async {
    Get.toNamed(AppRoutes.ADDTAGLINE);
  }
}
