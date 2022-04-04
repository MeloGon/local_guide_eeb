import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/access/access_binding.dart';
import 'package:locals_guide_eeb/modules/access/access_page.dart';
import 'package:locals_guide_eeb/route/app_routes.dart';

class AppPages{
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.ACCESS, page: ()=> const AccessPage(), binding: AccessBinding() )
  ];
}