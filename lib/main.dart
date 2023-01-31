
import 'package:flutter/material.dart';
import 'package:flutter_job/theme_provider.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/screen/res/themes.dart';
import 'package:flutter_job/ui/screen/settings_screen.dart';

void main() {
  runApp(App());
}

final themeProvider = ThemeProvider();

class App extends StatefulWidget {
  App({Key? key,}) : super(key: key);

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
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeProvider.isLightTheme ? lightThemes : darkThemes,
      title: AppStrings.appTitle,
      home: SettingsScreen(themeProvider: themeProvider,),
    );
  }
}
