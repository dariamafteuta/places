import 'package:flutter/material.dart';
import 'package:flutter_job/main.dart';

final errorBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: themeProvider.appTheme.redColor,
  ),
);

final enableBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: themeProvider.appTheme.greenColor,
  ),
  borderRadius: BorderRadius.circular(10),
);

final focusBorder = OutlineInputBorder(
  borderSide: BorderSide(
    width: 2,
    color: themeProvider.appTheme.greenColor,
  ),
  borderRadius: BorderRadius.circular(10),
);

final divider = Divider(
  color: themeProvider.appTheme.inactiveColor,
  thickness: 0.8,
);