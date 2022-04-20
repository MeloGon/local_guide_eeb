import 'package:get/get.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class AddAdressController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToAddDetailsLocalPage() async {
    Get.toNamed(AppRoutes.ADDDETAILSLOCAL);
  }
}
