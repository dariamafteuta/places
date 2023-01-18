import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_job/mocks.dart';
import 'package:flutter_job/theme_provider.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/screen/res/themes.dart';
import 'package:flutter_job/ui/screen/sight_details.dart';
import 'package:flutter_job/ui/screen/sight_list_screen.dart';
import 'package:flutter_job/ui/screen/visiting_screen.dart';

void main() {
  runApp(const App());
}

ThemeProvider themeProvider = ThemeProvider();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeProvider.isLight ? lightThemes : darkThemes,
      title: AppStrings.appTitle,
      home: const VisitingScreen(),
    );
  }
}
