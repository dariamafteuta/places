import 'package:flutter/material.dart';
import 'package:flutter_job/data/iterator/add_place_store.dart';
import 'package:flutter_job/data/iterator/favorite_store.dart';
import 'package:flutter_job/data/iterator/place_store.dart';
import 'package:flutter_job/data/iterator/visited_store.dart';
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
        Provider<PlaceStore>(
          create: (_) => PlaceStore(),
        ),
        Provider<FavoriteStore>(
          create: (_) => FavoriteStore(),
        ),
        Provider<VisitedStore>(
          create: (_) => VisitedStore(),
        ),
        Provider<AddPlaceStore>(
          create: (_) => AddPlaceStore(),
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
