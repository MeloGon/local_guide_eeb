import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_table_reserve/local_widgets/dynamic_widget.dart';

class AddTableReserveController extends GetxController {
  List<dynamicWidget> dynamicList = [];

  List<String>? _price = [];
  List<String>? get price => _price;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  addNewTable() {
    if (_price!.length != 0) {
      _price = [];
      dynamicList = [];
    }
    update();
    if (dynamicList.length >= 10) {
      return;
    }
    dynamicList.add(dynamicWidget(
      numeroMesa: dynamicList.length,
    ));
  }
}
