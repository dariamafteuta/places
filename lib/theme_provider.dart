import 'package:flutter_job/ui/res/app_colors.dart';

class ThemeProvider {
  bool isLight = true;

  BaseTheme get appTheme => isLight ? LightTheme() : DarkTheme();
}
