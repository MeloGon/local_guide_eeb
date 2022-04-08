import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/locals_admin/locals_admin_controller.dart';

class LocalsAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocalsAdminController());
  }
}
