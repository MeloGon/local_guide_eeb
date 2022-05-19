import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/user_module/user_maps/user_maps_controller.dart';

class UserMapsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserMapsController());
  }
}
