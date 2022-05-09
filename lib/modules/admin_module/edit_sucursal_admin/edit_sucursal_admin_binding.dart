import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/edit_sucursal_admin/edit_sucursal_admin_controller.dart';

class EditSucursalAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditSucursalAdminController());
  }
}
