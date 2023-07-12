import 'package:flutter/material.dart';
import 'package:flutter_job/ui/res/app_colors.dart';
import 'package:flutter_job/ui/res/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeProvider themeProvider = ThemeProvider();

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'isLightTheme';

  bool _isLightTheme = true;

  ThemeProvider() {
    _loadTheme();
  }

  bool get isLightTheme => _isLightTheme;

  AppColors get appTheme => _isLightTheme ? lightTheme : darkTheme;

  set isLightTheme(bool value) {
    _isLightTheme = value;
    _saveTheme(value);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isLightTheme = prefs.getBool(_themeKey) ?? true;
    notifyListeners();
  }

  Future<void> _saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, value);
  }
}
