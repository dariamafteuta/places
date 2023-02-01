import 'package:flutter/material.dart';
import 'package:flutter_job/theme_provider.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/screen/res/themes.dart';
import 'package:flutter_job/ui/screen/settings_screen.dart';

void main() {
  runApp(const App());
}

final themeProvider = ThemeProvider();

class App extends StatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    themeProvider.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    themeProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeProvider.isLightTheme ? lightThemes : darkThemes,
      title: AppStrings.appTitle,
      home: SettingsScreen(themeProvider: themeProvider),
    );
  }
}
