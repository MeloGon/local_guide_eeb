import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/data/models/mesa.dart';
import 'package:locals_guide_eeb/data/models/request_reserve.dart';

class ClientReserveController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<Mesa>? _mesas = [];
  List<Mesa>? get mesas => _mesas;

  List<RequestReserve>? _listaReservas = [];
  List<RequestReserve>? get listReservas => _listaReservas;

  //parametros que llegan
  String? _idLocal, _nombreLocal, _fotoLocal, _idSucursal;
  String? get nombreLocal => _nombreLocal;
  String? get fotoLocal => _fotoLocal;
  String? get idSucursal => _idSucursal;
  //--------------------------

  @override
  void onReady() {
    loadTables();
    loadRequestReserves();
    super.onReady();
  }

  @override
  void onInit() {
    setArguments();
    super.onInit();
  }

  setArguments() {
    _idLocal = Get.arguments[0] as String;
    _idSucursal = Get.arguments[1] as String;
    _fotoLocal = Get.arguments[2] as String;
    _nombreLocal = Get.arguments[3] as String;
  }

  loadTables() async {
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .collection("Mesas")
        .get()
        .then((docMesas) {
      for (var mesa in docMesas.docs) {
        final mesaData = Mesa.fromDocumentSnapshot(documentSnapshot: mesa);
        _mesas!.add(mesaData);
        update();
      }
    });
  }

  loadRequestReserves() async {
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .get()
        .then((sucursal) {
      sucursal.reference.collection("Reservas").get().then((docReservas) {
        for (var reservas in docReservas.docs) {
          final solicitudReserva =
              RequestReserve.fromDocumentSnapshot(documentSnapshot: reservas);
          _listaReservas!.add(solicitudReserva);
          update();
        }
      });
    });
  }
}
