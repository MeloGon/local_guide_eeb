import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/access/access_binding.dart';
import 'package:locals_guide_eeb/modules/access/access_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/activity_admin/activity_admin_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/activity_admin/activity_admin_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/admin_menu/admin_menu_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/admin_menu/admin_menu_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/categories_admin/categories_admin_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/categories_admin/categories_admin_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/info_admin/info_admin_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/info_admin/info_admin_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/locals_admin/locals_admin_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/locals_admin/locals_admin_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/users_admin/users_admin_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/users_admin/users_admin_page.dart';
import 'package:locals_guide_eeb/modules/client_module/client_menu/client_menu_binding.dart';
import 'package:locals_guide_eeb/modules/client_module/client_menu/client_menu_page.dart';

import 'package:locals_guide_eeb/modules/login/login_binding.dart';
import 'package:locals_guide_eeb/modules/login/login_page.dart';
import 'package:locals_guide_eeb/modules/otp/otp_binding.dart';
import 'package:locals_guide_eeb/modules/otp/otp_page.dart';
import 'package:locals_guide_eeb/modules/register/register_binding.dart';
import 'package:locals_guide_eeb/modules/register/register_page.dart';
import 'package:locals_guide_eeb/modules/register_phone/register_phone_binding.dart';
import 'package:locals_guide_eeb/modules/register_phone/register_phone_page.dart';

import 'package:locals_guide_eeb/route/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.ACCESS,
        page: () => const AccessPage(),
        binding: AccessBinding()),
    GetPage(
        name: AppRoutes.REGISTERMODE,
        page: () => const RegisterPage(),
        binding: RegisterBinding()),
    GetPage(
        name: AppRoutes.REGISTERPHONE,
        page: () => const RegisterPhonePage(),
        binding: RegisterPhoneBinding()),
    GetPage(
        name: AppRoutes.OTP,
        page: () => const OtpPage(),
        binding: OtpBinding()),
    GetPage(
        name: AppRoutes.LOGIN,
        page: () => const LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.ADMINMENU,
        page: () => const AdminMenuPage(),
        binding: AdminMenuBinding()),
    GetPage(
        name: AppRoutes.LOCALSADMIN,
        page: () => const LocalsAdminPage(),
        binding: LocalsAdminBinding()),
    GetPage(
        name: AppRoutes.USERSADMIN,
        page: () => const UsersAdminPage(),
        binding: UserAdminBinding()),
    GetPage(
        name: AppRoutes.CATEGORIESADMIN,
        page: () => const CategoriesAdminPage(),
        binding: CategoriesAdminBinding()),
    GetPage(
        name: AppRoutes.ACTIVITYADMIN,
        page: () => const ActivityAdminPage(),
        binding: ActivityAdminBinding()),
    GetPage(
        name: AppRoutes.INFOADMIN,
        page: () => const InfoAdminPage(),
        binding: InfoAdminBinding()),
    GetPage(
        name: AppRoutes.CLIENTMENU,
        page: () => const ClientMenuPage(),
        binding: ClientMenuBinding()),
  ];
}
