import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_details_local/add_details_local_controller.dart';

class AddDetailsLocalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddDetailsLocalController());
  }
}
