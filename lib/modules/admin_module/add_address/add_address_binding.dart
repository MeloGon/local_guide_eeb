import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_address/add_address_controller.dart';

class AddAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddAdressController());
  }
}
