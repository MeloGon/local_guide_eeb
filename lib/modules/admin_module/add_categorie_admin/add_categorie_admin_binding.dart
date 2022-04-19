import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_categorie_admin/add_categorie_admin_controller.dart';

class AddCategorieAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddCategorieAdminController());
  }
}
