import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
