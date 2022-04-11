import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/categories_admin/categories_admin_controller.dart';

class CategoriesAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoriesAdminController());
  }
}
