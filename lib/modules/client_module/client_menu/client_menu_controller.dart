import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/data/models/local.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class ClientMenuController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  QuerySnapshot? _querySnapshot;

  String? _idSucursal;
  String? _idLocal;
  Local? _local;
  Local? get local => _local;

  @override
  void onReady() {
    loadDataForLocal();
    super.onReady();
  }

  @override
  void onInit() {
    setArguments();
    super.onInit();
  }

  setArguments() {
    _idSucursal = Get.arguments[0] as String;
    _idLocal = Get.arguments[1] as String;
  }

  loadDataForLocal() async {
    //print(_idSucursal);
    //print(_idLocal);
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .get()
        .then((value) {
      _local = Local.fromDocumentSnapshot(documentSnapshot: value);
      update();
    });
  }

  void goToClientUbicationsPage() async {
//    print('el id de sucusal $_idSucursal');
    Get.toNamed(AppRoutes.CLIENTUBICATIONS, arguments: [
      _idLocal,
      _local!.nombreLocal,
      _local!.fotoLocal,
      _idSucursal,
    ]);
  }
}
