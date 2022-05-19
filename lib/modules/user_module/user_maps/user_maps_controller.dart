import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:locals_guide_eeb/route/app_routes.dart';

class UserMapsController extends GetxController {
  late GoogleMapController mapController;
  String? _mapStyle;
  String? get mapStyle => _mapStyle;

  @override
  void onInit() {
    rootBundle.loadString('assets/map_style.text').then((value) {
      _mapStyle = value;
    });
    super.onInit();
  }

  goToDrawerMenu() async {
    Get.toNamed(AppRoutes.USERDRAWER);
  }
}
