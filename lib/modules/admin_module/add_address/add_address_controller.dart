import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:flutter/services.dart' show rootBundle;

class AddAdressController extends GetxController {
  String? _mapStyle;
  String? get mapStyle => _mapStyle;

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
}
