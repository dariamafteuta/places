import 'package:flutter/material.dart';
import 'package:flutter_job/ui/res/app_colors.dart';

LightTheme lightTheme = LightTheme();
DarkTheme darkTheme = DarkTheme();

ThemeData lightThemes = ThemeData(
  sliderTheme: SliderThemeData(
    trackHeight: 2,
    activeTrackColor: lightTheme.greenColor,
    inactiveTrackColor: lightTheme.inactiveColor,
    thumbColor: lightTheme.whiteMainColor,
    overlayColor: Colors.transparent,
  ),

  primaryColor: lightTheme.backgroundColor,
  primaryColorLight: lightTheme.whiteColor,
  primaryColorDark: lightTheme.secondary2Color,
  backgroundColor: lightTheme.whiteColor,
  scaffoldBackgroundColor: lightTheme.whiteColor,

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 10,
    type: BottomNavigationBarType.fixed,
    backgroundColor: lightTheme.whiteColor,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),

  tabBarTheme: TabBarTheme(
    labelColor: lightTheme.whiteColor,
    unselectedLabelColor: lightTheme.inactiveColor,
    overlayColor: MaterialStateProperty.all(Colors.transparent),
    splashFactory: NoSplash.splashFactory,
    indicator: BoxDecoration(
      color: lightTheme.mainColor,
      borderRadius: BorderRadius.circular(40),
    ),
  ),

  appBarTheme: AppBarTheme(
    color: lightTheme.whiteColor,
  ),
);

ThemeData darkThemes = ThemeData(
  primaryColor: darkTheme.mainColor,
  scaffoldBackgroundColor: darkTheme.mainColor,

  sliderTheme: SliderThemeData(
    activeTrackColor: lightTheme.greenColor,
    inactiveTrackColor: lightTheme.inactiveColor,
    thumbColor: lightTheme.whiteMainColor,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 10,
    type: BottomNavigationBarType.fixed,
    backgroundColor: darkTheme.mainColor,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),

  tabBarTheme: TabBarTheme(
    labelColor: darkTheme.mainColor,
    unselectedLabelColor: darkTheme.inactiveColor,
    overlayColor: MaterialStateProperty.all(Colors.transparent),
    splashFactory: NoSplash.splashFactory,
    indicator: BoxDecoration(
      color: darkTheme.whiteColor,
      borderRadius: BorderRadius.circular(40),
    ),
  ),

  appBarTheme: AppBarTheme(
    color: darkTheme.mainColor,
  ),
);