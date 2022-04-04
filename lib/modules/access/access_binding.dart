import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/access/access_controller.dart';

class AccessBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AccessController());
  }

}