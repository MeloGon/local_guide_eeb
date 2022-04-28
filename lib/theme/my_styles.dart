import 'package:flutter/material.dart';
import 'package:locals_guide_eeb/theme/my_colors.dart';

class MyStyles {
  static const TextStyle logoStyle = TextStyle(
    color: MyColors.white,
    fontSize: 24.0, /*fontFamily: fontFamilyNotoSans*/
  );

  static const TextStyle logoSubttitle = TextStyle(
    color: MyColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle generalTextStyleWhite = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  static const TextStyle disableTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: 16,
  );

  static const TextStyle generalTextStyleWhiteBold = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle generalTextStyleBlack = TextStyle(
    color: Colors.black,
    fontSize: 16,
  );

  static const TextStyle generalTextStyleBlackBold = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle generalTextStyleRed = TextStyle(
    color: Colors.red,
    fontSize: 16,
  );

  static const TextStyle subtitleTextStyleWhite = TextStyle(
    color: Colors.white,
    fontSize: 14,
  );

  static const TextStyle subtitleTextStyleBlack = TextStyle(
    color: Colors.black,
    fontSize: 14,
  );
}
