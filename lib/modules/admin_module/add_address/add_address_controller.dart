import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';
import 'package:flutter/services.dart' show rootBundle;

class AddAdressController extends GetxController {
  String? _mapStyle;
  String? get mapStyle => _mapStyle;

  List<Marker>? _myMarker = [];
  List<Marker>? get myMarker => _myMarker;

  XFile? _photoLocal;
  XFile? get photoLocal => _photoLocal;

  String? _nameLocal;
  String? get nameLocal => _nameLocal;
  String? idLocal;

  String? _phoneNumber;
  String? get phoneNumber => _phoneNumber;
  set phoneNumberSet(String value) {
    _phoneNumber = value;
  }

  late TextEditingController txAddress;
  //late TextEditingController txNumberPhone;
  late TextEditingController txPwd;
  late TextEditingController txRepeatPwd;

  late GoogleMapController mapController;

  @override
  void onInit() {
    rootBundle.loadString('assets/map_style.text').then((value) {
      _mapStyle = value;
    });
    txAddress = TextEditingController();
    //txNumberPhone = TextEditingController();
    txPwd = TextEditingController();
    txRepeatPwd = TextEditingController();
    _setArguments();
    super.onInit();
  }

  _setArguments() {
    idLocal = Get.arguments[0] as String;
    _nameLocal = Get.arguments[1] as String;
    _photoLocal = Get.arguments[2] as XFile;
  }

  void goToAddDetailsLocalPage() async {
    Get.toNamed(AppRoutes.ADDDETAILSLOCAL, arguments: [
      idLocal,
      _nameLocal,
      _photoLocal,
      txAddress.text,
      _phoneNumber,
      txPwd.text,
      txRepeatPwd.text,
    ]);
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
