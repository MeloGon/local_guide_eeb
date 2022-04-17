import 'package:get/get.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class ClientMenuController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToClientUbicationsPage() async {
    Get.toNamed(AppRoutes.CLIENTUBICATIONS);
  }
}
