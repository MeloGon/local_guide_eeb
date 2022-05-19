import 'package:flutter/material.dart';
import 'package:locals_guide_eeb/theme/my_styles.dart';
import 'package:locals_guide_eeb/utils/my_strings.dart';

AppBar appBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    title: const Text(
      MyStrings.FILTERS,
      style: MyStyles.generalTextStyleBlackBold,
    ),
    leading: Container(
      margin: const EdgeInsets.all(10),
      width: 30,
      height: 30,
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
  );
}
