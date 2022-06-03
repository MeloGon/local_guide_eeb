import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_tagline/add_tagline_controller.dart';

class AddTaglineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTaglineController());
  }
}
