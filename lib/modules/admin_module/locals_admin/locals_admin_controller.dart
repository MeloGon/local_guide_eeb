import 'package:get/get.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class LocalsAdminController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToAddLocalAdminPage() async {
    Get.toNamed(AppRoutes.ADDLOCALADMIN);
  }
}
