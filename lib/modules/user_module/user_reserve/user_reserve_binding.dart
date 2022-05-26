import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/user_module/user_reserve/user_reserve_controller.dart';

class UserReserveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserReserveController());
  }
}
