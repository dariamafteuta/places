import 'package:flutter/material.dart';
import 'package:flutter_job/dio.dart';
import 'package:flutter_job/theme_provider.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/screens/res/themes.dart';

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
      initialRoute: AppNavigation.sightListScreen,
      onGenerateRoute: AppNavigation.generateRoute,
    );
  }

  @override
  void initState() {
    super.initState();
    testNetworkCall();
    themeProvider.addListener(_onThemeChange);
  }

  @override
  void dispose() {
    themeProvider.removeListener(_onThemeChange);
    super.dispose();
  }

  Future<void> testNetworkCall() async {
    final dynamic response = await getPost();
    debugPrint('Response HTTP  call = $response');
  }

  void _onThemeChange() {
    setState(() {});
  }
}
