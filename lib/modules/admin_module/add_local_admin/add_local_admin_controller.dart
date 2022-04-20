import 'package:get/get.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class AddLocalAdminController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToAddAddressPage() async {
    Get.toNamed(AppRoutes.ADDADDRESS);
  }
}
