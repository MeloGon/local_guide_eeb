import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/user_module/user_menu/user_menu_controller.dart';

class UserMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserMenuController());
  }
}
