import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/data/models/mesa.dart';
import 'package:locals_guide_eeb/data/models/request_reserve.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';
import 'package:random_string/random_string.dart';

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
    _mesas!.clear();
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
    _listaReservas!.clear();
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

  acceptReserva(RequestReserve reserve, String idUsuario) async {
    Get.snackbar('Información', 'Has aceptado la reserva',
        colorText: MyColors.blackBg, backgroundColor: MyColors.white);
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .collection("Reservas")
        .doc(reserve.idReserva)
        .update({
      'isAcepted': true,
    }).then((value) {
      loadRequestReserves();
      update();
    });
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .collection("Mesas")
        .doc(reserve.idMesa)
        .update({
      'reservado': true,
    }).then((value) {
      loadTables();
      update();
    });
    sendNotification(idUsuario, reserve.idReserva!,
        'Tu reserva en $_nombreLocal en la mesa nro. ${reserve.mesa} ha sido aceptada');
  }

  deniedReserve(RequestReserve reserve, String idUsuario) async {
    Get.snackbar('Información', 'Has rechazado la reserva',
        colorText: MyColors.blackBg, backgroundColor: MyColors.white);

    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .collection("Reservas")
        .doc(reserve.idReserva)
        .delete()
        .then((value) {
      loadRequestReserves();
      update();
    });
    sendNotification(idUsuario, reserve.idReserva!,
        'Tu reserva en $_nombreLocal en la mesa nro. ${reserve.mesa} ha sido rechazada');
  }

  sendNotification(String idUsuario, String idReserva, String content) async {
    var idNotificacion = (randomAlphaNumeric(8));
    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Usuarios")
        .doc(idUsuario)
        .collection("Notificaciones")
        .doc(idNotificacion)
        .set({
      'idNotificacion': idNotificacion,
      'notificacion': content,
    });
  }

  deleteReserve(RequestReserve reserve) async {
    Get.snackbar('Información', 'Has eliminado la reserva',
        colorText: MyColors.blackBg, backgroundColor: MyColors.white);

    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .collection("Reservas")
        .doc(reserve.idReserva)
        .delete()
        .then((value) {
      loadRequestReserves();
      update();
    });

    await firebaseFirestore
        .collection("GuiaLocales")
        .doc("admin")
        .collection("Locales")
        .doc(_idLocal)
        .collection("Sucursales")
        .doc(_idSucursal)
        .collection("Mesas")
        .doc(reserve.idMesa)
        .update({
      'reservado': false,
    }).then((value) {
      loadTables();
      update();
    });
  }
}
