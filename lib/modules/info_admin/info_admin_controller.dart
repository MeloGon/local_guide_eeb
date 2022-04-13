import 'package:get/get.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class InfoAdminController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToCategoriesPage() async {
    Get.toNamed(AppRoutes.CATEGORIESADMIN);
  }
}
