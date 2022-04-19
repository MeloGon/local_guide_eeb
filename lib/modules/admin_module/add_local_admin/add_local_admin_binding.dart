import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_local_admin/add_local_admin_controller.dart';

class AddLocalAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddLocalAdminController());
  }
}
