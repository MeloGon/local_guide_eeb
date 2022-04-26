import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:flutter/services.dart' show rootBundle;

class AddAdressController extends GetxController {
  String? _mapStyle;
  String? get mapStyle => _mapStyle;

  List<Marker>? _myMarker = [];
  List<Marker>? get myMarker => _myMarker;

  late GoogleMapController mapController;

  @override
  void onInit() {
    rootBundle.loadString('assets/map_style.text').then((value) {
      _mapStyle = value;
    });
    super.onInit();
  }

  void goToAddDetailsLocalPage() async {
    Get.toNamed(AppRoutes.ADDDETAILSLOCAL);
  }

  putMarker(LatLng tapPoint) {
    _myMarker = [];
    _myMarker!.add(Marker(
        markerId: MarkerId(tapPoint.toString()),
        position: tapPoint,
        draggable: true));
    update();
  }
}
