import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_food/add_food_controller.dart';

class AddFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddFoodController());
  }
}
