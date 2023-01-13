import 'package:flutter/material.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_colors.dart';

class AppTypography {
  static const text40Bold = TextStyle(
    color: !isDarkTheme ? AppColors.ltMainColor : AppColors.whiteColor,
    fontSize: 40,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
  );

  static const text14Bold = TextStyle(
    color: !isDarkTheme ? AppColors.secondaryColor : AppColors.secondary2Color,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );

  static const text24Bold = TextStyle(
    color: !isDarkTheme ? AppColors.ltMainColor : AppColors.whiteColor,
    fontSize: 24,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );

  static const text16Bold = TextStyle(
    color: !isDarkTheme ? AppColors.secondaryColor : AppColors.whiteColor,
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );

  static const textGreyInactive14Regular = TextStyle(
    color: AppColors.inactiveColor,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
  );

  static const textGreyInactive18Bold = TextStyle(
    color: AppColors.inactiveColor,
    fontSize: 18,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );

  static const text14Regular = TextStyle(
    color: !isDarkTheme ? AppColors.secondaryColor : AppColors.whiteColor,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
  );

  static const text14w700 = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
  );
}
