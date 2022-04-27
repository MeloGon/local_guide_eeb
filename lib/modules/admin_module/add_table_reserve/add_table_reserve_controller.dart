import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_table_reserve/local_widgets/dynamic_widget.dart';

class AddTableReserveController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<dynamicWidget> dynamicList = [];

  List<String>? _table = [];
  List<String>? get table => _table;

  String? _idLocal;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  addNewTable() {
    if (_table!.length != 0) {
      _table = [];
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

  sendNewLocalData() async {
    dynamicList
        .forEach((widget) => _table!.add(widget.capacityController.text));

    // await firebaseFirestore
    //     .collection("GuiaLocales")
    //     .doc("admin")
    //     .collection("Locales")
    //     .doc(_idLocal)
    //     .set({
    //   'idLocal': _idLocal,
    //   'nombreLocal': txNombreCat.text,
    //   'ubicacionLocal': txColorCat,
    //   'telefonoLocal': _idLocal,
    //   'pwdLocal': _idLocal,
    //   'repeatPwd': _idLocal,
    //   'categoria': _idLocal,
    //   'precioLocal': _idLocal,
    //   'linkLocal': _idLocal,
    //   'linkWeb': _idLocal,
    //   'linkDelivery': _idLocal,
    //   'aforoLocal': _idLocal,
    //   //falta aqui as mesas
    // });
  }
}
