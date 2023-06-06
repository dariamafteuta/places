import 'package:flutter/material.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';

AppTypography appTypography = AppTypography();

class AppTypography {
  TextStyle text30Bold = const TextStyle(
    fontSize: 30,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
  );

  TextStyle text14Bold = const TextStyle(
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );

  TextStyle text24Bold = const TextStyle(
    fontSize: 24,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );

  TextStyle text16Bold = const TextStyle(
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );

  TextStyle text14Regular = const TextStyle(
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
  );

  TextStyle textGreen18Bold = const TextStyle(
    fontSize: 18,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );

  TextStyle text14w700 = const TextStyle(
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
  );

  TextStyle textGreyInactive14Regular = TextStyle(
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
}
