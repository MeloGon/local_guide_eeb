import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/info_admin/info_admin_controller.dart';

class InfoAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InfoAdminController());
  }
}
