import 'package:flutter/material.dart';
import 'package:locals_guide_eeb/modules/user_module/user_menu/user_menu_controller.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';

AppBar appBar(UserMenuController _) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    title: const Text(
      MyStrings.FILTERS,
      style: MyStyles.generalTextStyleBlackBold,
    ),
  );
}
