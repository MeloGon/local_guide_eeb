import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/admin_menu/admin_menu_controller.dart';

class AdminMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminMenuController());
  }
}
