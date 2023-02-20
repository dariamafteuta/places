import 'package:flutter/material.dart';
import 'package:flutter_job/theme_provider.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/screen/res/themes.dart';
import 'package:flutter_job/ui/screen/sight_list_screen.dart';

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
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeProvider.isLightTheme ? lightThemes : darkThemes,
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      home: const SightListScreen(),
    );
  }

  @override
  void initState() {
    super.initState();
    themeProvider.addListener(_onThemeChange);
  }

  @override
  void dispose() {
    themeProvider.removeListener(_onThemeChange);
    super.dispose();
  }

  void _onThemeChange() {
    setState(() {});
  }
}
