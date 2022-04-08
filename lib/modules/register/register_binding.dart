import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/register/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}
