import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class UserDrawerController extends GetxController {
  String? _idUser, _displayName, _photoUrl;
  String? get displayName => _displayName;
  String? get photoUrl => _photoUrl;

  @override
  void onInit() {
    setArguments();
    super.onInit();
  }

  setArguments() {
    _idUser = Get.arguments[0];
    _displayName = Get.arguments[1];
    _photoUrl = Get.arguments[2];
  }

  goToHomeUser() async {
    Get.toNamed(AppRoutes.USERHOME, arguments: [
      _idUser,
      _displayName,
      _photoUrl,
    ]);
  }

  signOut() async {
    await GoogleSignIn().signOut();
    Get.offAllNamed(AppRoutes.ACCESS);
  }
}
