import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/users_admin/users_admin_controller.dart';

class UserAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UsersAdminController());
  }
}
