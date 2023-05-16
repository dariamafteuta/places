import 'package:flutter/material.dart';
import 'package:flutter_job/data/iterator/add_place_provider.dart';
import 'package:flutter_job/data/iterator/favorite_provider.dart';
import 'package:flutter_job/data/iterator/place_provider.dart';
import 'package:flutter_job/data/iterator/visited_provider.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/screens/res/themes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

final themeProvider = ThemeProvider();

double userLatitude = 0;
double userLongitude = 0;

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<PlaceProvider>(
          create: (_) => PlaceProvider(),
        ),
        ChangeNotifierProvider<FavoriteProvider>(
          create: (_) => FavoriteProvider(),
        ),
        ChangeNotifierProvider<VisitedProvider>(
          create: (_) => VisitedProvider(),
        ),
        ChangeNotifierProvider<AddPlaceProvider>(
          create: (_) => AddPlaceProvider(),
        ),
      ],
      child: MaterialApp(
        theme: themeProvider.isLightTheme ? lightThemes : darkThemes,
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        initialRoute: AppNavigation.onBoardingScreen,
        onGenerateRoute: AppNavigation.generateRoute,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
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

  Future<void> _getUserLocation() async {
    final position = await _locationPermission();
    setState(() {
      userLongitude = position.longitude;
      userLatitude = position.latitude;
    });
  }

  Future<Position> _locationPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Error');
      }
    }

    return Geolocator.getCurrentPosition();
  }
}
