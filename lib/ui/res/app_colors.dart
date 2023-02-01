// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';

class BaseTheme {
  Color? mainColor ;
  Color? backgroundColor;
  Color? greenColor;
  Color? yellowColor;
  Color? redColor;

  Color? secondaryColor;
  Color? secondary2Color;
  Color? inactiveColor;
  Color? whiteColor;

  Color? secondarySecondary2Color;
  Color? mainWhiteColor;
  Color? secondaryWhiteColor;
  Color? whiteMainColor;
}


class LightTheme implements BaseTheme {
  @override
  Color? mainColor = const Color.fromRGBO(42, 44, 76, 1.0);
  @override
  Color? backgroundColor = const Color.fromRGBO(245, 245, 245, 1.0);
  @override
  Color? greenColor = const Color.fromRGBO(98, 177, 76, 1.0);
  @override
  Color? yellowColor = const Color.fromRGBO(248, 220, 21, 1.0);
  @override
  Color? redColor = const Color.fromRGBO(224, 46, 59, 1.0);

  @override
  Color? secondaryColor = const Color.fromRGBO(62, 64, 93, 1.0);
  @override
  Color? secondary2Color = const Color.fromRGBO(123, 125, 146, 1.0);
  @override
  Color? inactiveColor = const Color.fromRGBO(181, 181, 193, 1.0);
  @override
  Color? whiteColor = const Color.fromRGBO(255, 255, 255, 1.0);

  @override
  Color? secondarySecondary2Color = const Color.fromRGBO(62, 64, 93, 1.0);
  @override
  Color? mainWhiteColor = const Color.fromRGBO(42, 44, 76, 1.0);
  @override
  Color? secondaryWhiteColor = const Color.fromRGBO(62, 64, 93, 1.0);
  @override
  Color? whiteMainColor = const Color.fromRGBO(255, 255, 255, 1.0);
}

class DarkTheme extends BaseTheme{
  @override
  Color? mainColor = const Color.fromRGBO(38, 39, 48, 1.0);
  @override
  Color? backgroundColor = const Color.fromRGBO(31, 32, 37, 1.0);
  @override
  Color? greenColor = const Color.fromRGBO(128, 221, 105, 1.0);
  @override
  Color? yellowColor = const Color.fromRGBO(252, 230, 90, 1.0);
  @override
  Color? redColor = const Color.fromRGBO(193, 0, 33, 1.0);

  @override
  Color? secondaryColor = const Color.fromRGBO(62, 64, 93, 1.0);
  @override
  Color? secondary2Color = const Color.fromRGBO(123, 125, 146, 1.0);
  @override
  Color? inactiveColor = const Color.fromRGBO(181, 181, 193, 1.0);
  @override
  Color? whiteColor = const Color.fromRGBO(255, 255, 255, 1.0);

  @override
  Color? secondarySecondary2Color = const Color.fromRGBO(123, 125, 146, 1.0);
  @override
  Color? mainWhiteColor = const Color.fromRGBO(255, 255, 255, 1.0);
  @override
  Color? secondaryWhiteColor = const Color.fromRGBO(255, 255, 255, 1.0);
  @override
  Color? whiteMainColor = const Color.fromRGBO(38, 39, 48, 1.0);
}
