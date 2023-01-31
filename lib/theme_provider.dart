// ignore_for_file: prefer_mixin

import 'package:flutter/material.dart';
import 'package:flutter_job/ui/res/app_colors.dart';
import 'package:flutter_job/ui/screen/res/themes.dart';
import 'package:flutter_job/ui/screen/settings_screen.dart';
import 'package:provider/provider.dart';

class ThemeProvider with ChangeNotifier {
  bool _isLightTheme = true;

  bool get isLightTheme => _isLightTheme;

  BaseTheme get appTheme => _isLightTheme ? lightTheme : darkTheme;

  set isLightTheme(bool value) {
    _isLightTheme = value;
    notifyListeners();
  }
}
