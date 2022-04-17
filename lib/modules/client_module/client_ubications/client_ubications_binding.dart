import 'package:get/instance_manager.dart';
import 'package:locals_guide_eeb/modules/client_module/client_ubications/client_ubications_controller.dart';

class ClientUbicationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClientUbicationsController());
  }
}
