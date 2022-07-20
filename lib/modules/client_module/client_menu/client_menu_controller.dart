import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
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
  int _reserveRequest = 0;
  int get reserveRequest => _reserveRequest;

  @override
  void onReady() {
    loadDataForLocal();
    checkIfThereReserves();
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

  getPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error(
          'Los servicios de localizacion estan deshabilitados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Los permisos de localizacion han sido denegados');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Los permisos de localizacion han sido denegados permanentemente');
    }
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

  checkIfThereReserves() async {
    _reserveRequest = 0;
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
          _reserveRequest = _reserveRequest + 1;
          update();
        }
      });
    });
  }

  void goToClientUbicationsPage(int tab) async {
//    print('el id de sucusal $_idSucursal');
    Get.toNamed(AppRoutes.CLIENTUBICATIONS, arguments: [
      _idLocal,
      _local!.nombreLocal,
      _local!.fotoLocal,
      _idSucursal,
      tab,
      _local!.tipoUsuario,
    ]);
  }

  goToListOfReserves() async {
    Get.toNamed(AppRoutes.CLIENTRESERVE, arguments: [
      _idLocal,
      _idSucursal,
      _local!.fotoLocal,
      _local!.nombreLocal,
    ]);
  }

  logout() async {
    Get.offAllNamed(AppRoutes.ACCESS);
  }
}
