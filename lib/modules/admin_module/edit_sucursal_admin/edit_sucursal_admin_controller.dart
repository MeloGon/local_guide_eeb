import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditSucursalAdminController extends GetxController {
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

  String? _idSucursal;

  late TextEditingController txAddress;
  //late TextEditingController txNumberPhone;
  late TextEditingController txNick;
  late TextEditingController txPwd;
  late TextEditingController txRepeatPwd;

  late GoogleMapController mapController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
