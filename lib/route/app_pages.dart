import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locals_guide_eeb/modules/access/access_binding.dart';
import 'package:locals_guide_eeb/modules/access/access_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/activity_admin/activity_admin_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/activity_admin/activity_admin_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_address/add_address_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_address/add_address_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_categorie_admin/add_categorie_admin_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_categorie_admin/add_categorie_admin_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_details_local/add_details_local_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_details_local/add_details_local_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_local_admin/add_local_admin_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_local_admin/add_local_admin_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_table_reserve/add_table_reserve_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/add_table_reserve/add_table_reserve_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/admin_menu/admin_menu_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/admin_menu/admin_menu_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/categories_admin/categories_admin_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/categories_admin/categories_admin_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/edit_sucursal_admin/edit_sucursal_admin_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/edit_sucursal_admin/edit_sucursal_admin_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/info_admin/info_admin_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/info_admin/info_admin_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/locals_admin/locals_admin_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/locals_admin/locals_admin_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/sucursal_admin/sucursal_admin_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/sucursal_admin/sucursal_admin_page.dart';
import 'package:locals_guide_eeb/modules/admin_module/users_admin/users_admin_binding.dart';
import 'package:locals_guide_eeb/modules/admin_module/users_admin/users_admin_page.dart';
import 'package:locals_guide_eeb/modules/client_module/client_menu/client_menu_binding.dart';
import 'package:locals_guide_eeb/modules/client_module/client_menu/client_menu_page.dart';
import 'package:locals_guide_eeb/modules/client_module/client_reserve/client_reserve_binding.dart';
import 'package:locals_guide_eeb/modules/client_module/client_reserve/client_reserve_page.dart';
import 'package:locals_guide_eeb/modules/client_module/client_ubications/client_ubications_binding.dart';
import 'package:locals_guide_eeb/modules/client_module/client_ubications/client_ubications_page.dart';

import 'package:locals_guide_eeb/modules/login/login_binding.dart';
import 'package:locals_guide_eeb/modules/login/login_page.dart';
import 'package:locals_guide_eeb/modules/otp/otp_binding.dart';
import 'package:locals_guide_eeb/modules/otp/otp_page.dart';
import 'package:locals_guide_eeb/modules/register/register_binding.dart';
import 'package:locals_guide_eeb/modules/register/register_page.dart';
import 'package:locals_guide_eeb/modules/register_phone/register_phone_binding.dart';
import 'package:locals_guide_eeb/modules/register_phone/register_phone_page.dart';
import 'package:locals_guide_eeb/modules/user_module/user_drawer/user_drawer_binding.dart';
import 'package:locals_guide_eeb/modules/user_module/user_drawer/user_drawer_page.dart';
import 'package:locals_guide_eeb/modules/user_module/user_home/user_home_binding.dart';
import 'package:locals_guide_eeb/modules/user_module/user_home/user_home_controller.dart';
import 'package:locals_guide_eeb/modules/user_module/user_home/user_home_page.dart';
import 'package:locals_guide_eeb/modules/user_module/user_maps/user_maps_binding.dart';
import 'package:locals_guide_eeb/modules/user_module/user_maps/user_maps_page.dart';
import 'package:locals_guide_eeb/modules/user_module/user_menu/user_menu_binding.dart';
import 'package:locals_guide_eeb/modules/user_module/user_menu/user_menu_page.dart';
import 'package:locals_guide_eeb/modules/user_module/user_reserve/user_reserve_binding.dart';
import 'package:locals_guide_eeb/modules/user_module/user_reserve/user_reserve_page.dart';

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
    GetPage(
        name: AppRoutes.CLIENTUBICATIONS,
        page: () => const ClientUbicationsPage(),
        binding: ClientUbicationsBinding()),
    GetPage(
        name: AppRoutes.ADDCATEGORIEADMIN,
        page: () => const AddCategorieAdminPage(),
        binding: AddCategorieAdminBinding()),
    GetPage(
        name: AppRoutes.ADDLOCALADMIN,
        page: () => const AddLocalAdminPage(),
        binding: AddLocalAdminBinding()),
    GetPage(
        name: AppRoutes.ADDADDRESS,
        page: () => const AddAddressPage(),
        binding: AddAddressBinding()),
    GetPage(
        name: AppRoutes.ADDDETAILSLOCAL,
        page: () => const AddDetailsLocalPage(),
        binding: AddDetailsLocalBinding()),
    GetPage(
        name: AppRoutes.ADDTABLERESERVE,
        page: () => const AddTableReservePage(),
        binding: AddTableReserveBinding()),
    GetPage(
        name: AppRoutes.SUCURSALADMIN,
        page: () => const SucursalAdminPage(),
        binding: SucursalAdminBinding()),
    GetPage(
        name: AppRoutes.EDITSUCURSALADMIN,
        page: () => const EditSucursalAdminPage(),
        binding: EditSucursalAdminBinding()),
    GetPage(
        name: AppRoutes.USERMENU,
        page: () => const UserMenuPage(),
        binding: UserMenuBinding()),
    GetPage(
        transition: Transition.rightToLeft,
        curve: Curves.easeInOutQuart,
        transitionDuration: const Duration(milliseconds: 1500),
        name: AppRoutes.USERMAPS,
        page: () => const UserMapsPage(),
        binding: UserMapsBinding()),
    GetPage(
        name: AppRoutes.USERDRAWER,
        page: () => const UserDrawerPage(),
        binding: UserDrawerBinding()),
    GetPage(
        name: AppRoutes.USERHOME,
        page: () => const UserHomePage(),
        binding: UserHomeBinding()),
    GetPage(
        name: AppRoutes.USERRESERVE,
        page: () => const UserReservePage(),
        binding: UserReserveBinding()),
    GetPage(
        name: AppRoutes.CLIENTRESERVE,
        page: () => const ClientReservePage(),
        binding: ClientReserveBinding()),
  ];
}
