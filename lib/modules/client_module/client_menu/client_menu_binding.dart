import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/client_module/client_menu/client_menu_controller.dart';

class ClientMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClientMenuController());
  }
}
