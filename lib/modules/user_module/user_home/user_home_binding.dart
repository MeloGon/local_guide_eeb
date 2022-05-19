import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/user_module/user_home/user_home_controller.dart';

class UserHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserHomeController());
  }
}
