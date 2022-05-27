import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/client_module/client_reserve/client_reserve_controller.dart';

class ClientReserveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClientReserveController());
  }
}
