import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/register_phone/register_phone_controller.dart';

class RegisterPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterPhoneController());
  }
}
