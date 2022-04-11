import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/activity_admin/activity_admin_controller.dart';

class ActivityAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityAdminController());
  }
}
