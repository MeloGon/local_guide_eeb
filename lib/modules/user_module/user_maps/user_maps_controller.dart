import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

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
}
