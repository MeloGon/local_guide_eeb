import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_logo/add_logo_controller.dart';

class AddLogoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddLogoController());
  }
}
