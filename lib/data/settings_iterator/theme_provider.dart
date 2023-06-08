import 'package:flutter/material.dart';
import 'package:flutter_job/ui/res/app_colors.dart';
import 'package:flutter_job/ui/res/themes.dart';

ThemeProvider themeProvider = ThemeProvider();

class ThemeProvider extends ChangeNotifier {
  set isLightTheme(bool value) {
    _isLightTheme = value;
    notifyListeners();
  }

  AppColors get appTheme => _isLightTheme ? lightTheme : darkTheme;

  bool get isLightTheme => _isLightTheme;

  bool _isLightTheme = true;
}
