import 'package:get/get.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class CategoriesAdminController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToAddCategorieAdminPage() async {
    Get.toNamed(AppRoutes.ADDCATEGORIEADMIN);
  }
}
