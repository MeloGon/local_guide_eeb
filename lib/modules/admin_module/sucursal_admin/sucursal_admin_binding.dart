import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/sucursal_admin/sucursal_admin_controller.dart';

class SucursalAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SucursalAdminController());
  }
}
