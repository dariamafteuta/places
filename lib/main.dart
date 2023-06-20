import 'package:flutter/material.dart';
import 'package:flutter_job/data/redux/search_reducer.dart';
import 'package:flutter_job/data/redux/search_state.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/data/store/add_place_store_base.dart';
import 'package:flutter_job/data/store/favorite_store_base.dart';
import 'package:flutter_job/data/store/place_store_base.dart';
import 'package:flutter_job/data/store/search_place_store_base.dart';
import 'package:flutter_job/mwwm/add_place_widget_model.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/themes.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(const Main());
}

double userLatitude = 0;
double userLongitude = 0;

class Main extends StatefulWidget {
  const Main({
    Key? key,
  }) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
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
    final store = Store<SearchState>(
      rootReducer,
      initialState: SearchState.initialState(),
    );

    return StoreProvider(
      store: store,
      child: MultiProvider(
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
          // Provider<AddPlaceWidgetModel>(
          //   create: (_) => AddPlaceWidgetModel(
          //      const WidgetModelDependencies(),
          //   ),
          // ),
          Provider<AddPlaceStore>(
            create: (_) => AddPlaceStore(),
          ),
          Provider<SearchPlaceStore>.value(value: SearchPlaceStore()),
        ],
        child: MaterialApp(
          theme: themeProvider.isLightTheme ? lightThemes : darkThemes,
          title: AppStrings.appTitle,
          debugShowCheckedModeBanner: false,
          initialRoute: AppNavigation.splashScreen,
          onGenerateRoute: AppNavigation.generateRoute,
        ),
      ),
    );
  }
}
