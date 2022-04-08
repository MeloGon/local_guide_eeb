import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/otp/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }
}
