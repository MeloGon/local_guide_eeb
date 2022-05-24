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
    leading: GestureDetector(
      onTap: _.hideFilter,
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
        width: 45,
        height: 45,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: const Icon(
          Icons.menu_rounded,
          size: 20,
        ),
      ),
    ),
  );
}
