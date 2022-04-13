import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/users_admin/users_admin_controller.dart';

class UserAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UsersAdminController());
  }
}
