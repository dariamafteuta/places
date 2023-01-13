import 'package:flutter/material.dart';
import 'package:flutter_job/ui/res/app_colors.dart';

final lightTheme = ThemeData(
  primaryColor: AppColors.ltBackgroundColor,
  primaryColorLight: AppColors.whiteColor,
  primaryColorDark: AppColors.secondary2Color,
  backgroundColor: AppColors.whiteColor,
  scaffoldBackgroundColor: AppColors.whiteColor,

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 10,
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColors.whiteColor,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),

  tabBarTheme: TabBarTheme(
    labelColor: AppColors.whiteColor,
    unselectedLabelColor: AppColors.inactiveColor,
    overlayColor: MaterialStateProperty.all(Colors.transparent),
    splashFactory: NoSplash.splashFactory,
    indicator: BoxDecoration(
      color: AppColors.ltMainColor,
      borderRadius: BorderRadius.circular(40),
    ),
  ),

  appBarTheme: const AppBarTheme(
    color: AppColors.whiteColor,
  ),
);

final darkTheme = ThemeData(
  primaryColor: AppColors.dtMainColor,
  scaffoldBackgroundColor: AppColors.dtMainColor,

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 10,
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColors.dtMainColor,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),

  tabBarTheme: TabBarTheme(
    labelColor: AppColors.dtMainColor,
    unselectedLabelColor: AppColors.inactiveColor,
    overlayColor: MaterialStateProperty.all(Colors.transparent),
    splashFactory: NoSplash.splashFactory,
    indicator: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(40),
    ),
  ),

  appBarTheme: const AppBarTheme(
    color: AppColors.dtMainColor,
  ),
);