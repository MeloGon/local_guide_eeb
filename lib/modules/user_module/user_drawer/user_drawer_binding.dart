import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/user_module/user_drawer/user_drawer_controller.dart';

class UserDrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserDrawerController());
  }
}
