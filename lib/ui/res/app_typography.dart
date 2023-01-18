import 'package:flutter/material.dart';
import 'package:flutter_job/theme_provider.dart';

ThemeProvider themeProvider = ThemeProvider();
class AppTypography {

  TextStyle text40Bold = TextStyle(
    color: themeProvider.appTheme.mainWhiteColor,
    fontSize: 40,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
  );

  TextStyle text14Bold = TextStyle(
    color: themeProvider.appTheme.secondarySecondary2Color,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );

  TextStyle text24Bold = TextStyle(
    color: themeProvider.appTheme.mainWhiteColor,
    fontSize: 24,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );

  TextStyle text16Bold = TextStyle(
    color: themeProvider.appTheme.secondaryWhiteColor,
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );

  TextStyle? textGreyInactive14Regular = TextStyle(
    color: themeProvider.appTheme.inactiveColor,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
  );

  TextStyle textGreyInactive18Bold = TextStyle(
    color: themeProvider.appTheme.inactiveColor,
    fontSize: 18,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );

  TextStyle text14Regular = TextStyle(
    color: themeProvider.appTheme.secondaryWhiteColor,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
  );

  TextStyle text14w700 = TextStyle(
    color: themeProvider.appTheme.whiteColor,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
  );
}
