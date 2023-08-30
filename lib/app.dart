import 'package:flutter/material.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/data/store/add_place_store_base.dart';
import 'package:flutter_job/data/store/places_store_base.dart';
import 'package:flutter_job/data/store/search_place_store_base.dart';
import 'package:flutter_job/database/app_database.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/themes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();
    _getUserLocation();
    themeProvider.addListener(_onThemeChange);
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

  @override
  void dispose() {
    themeProvider.removeListener(_onThemeChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        Provider<PlacesStore>(
          create: (_) => PlacesStore(),
        ),
        Provider<AddPlaceStore>(
          create: (_) => AddPlaceStore(),
        ),
        Provider<SearchPlaceStore>(
          create: (_) => SearchPlaceStore(),
        ),
        Provider<AppDatabase>(
          create: (_) => AppDatabase(),
        ),
      ],
      child: MaterialApp(
        theme: themeProvider.isLightTheme ? lightThemes : darkThemes,
        title: AppStrings.appTitle,
        initialRoute: AppNavigation.splashScreen,
        onGenerateRoute: AppNavigation.generateRoute,
      ),
    );
  }
}
