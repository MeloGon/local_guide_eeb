import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_table_reserve/add_table_reserve_controller.dart';

class AddTableReserveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTableReserveController());
  }
}
