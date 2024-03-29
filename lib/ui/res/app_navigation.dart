import 'package:flutter/material.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/ui/screens/filters_screen.dart';
import 'package:flutter_job/ui/screens/map_screen/map_screen.dart';
import 'package:flutter_job/ui/screens/new_place_screen/add_sight_screen.dart';
import 'package:flutter_job/ui/screens/new_place_screen/new_place_category.dart';
import 'package:flutter_job/ui/screens/on_boarding_screen.dart';
import 'package:flutter_job/ui/screens/settings_screen.dart';
import 'package:flutter_job/ui/screens/sight_details_screen/sight_details_screen.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_list_screen.dart';
import 'package:flutter_job/ui/screens/sight_search_screen.dart';
import 'package:flutter_job/ui/screens/splash_screen.dart';
import 'package:flutter_job/ui/screens/visiting_screen/favorite_screen.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class AppNavigation {
  static const String splashScreen = '/splash_screen';
  static const String onBoardingScreen = '/on_boarding_screen';
  static const String sightListScreen = '/sight_list_screen';
  static const String visitingScreen = '/visiting_screen';
  static const String settingsScreen = '/settings_screen';
  static const String sightSearchScreen = '/sight_search_screen';
  static const String mapScreen = '/map_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute<SplashScreen>(
          builder: (_) => const SplashScreen(),
        );
      case onBoardingScreen:
        return MaterialPageRoute<OnBoardingScreen>(
          builder: (_) => const OnBoardingScreen(),
        );
      case sightListScreen:
        return MaterialPageRoute<SightListScreen>(
          builder: (_) => const SightListScreen(),
        );
      case visitingScreen:
        return MaterialPageRoute<FavoriteScreen>(
          builder: (_) => const FavoriteScreen(),
        );
      case settingsScreen:
        return MaterialPageRoute<SettingsScreen>(
          builder: (_) => SettingsScreen(themeProvider: themeProvider,),
        );
      case mapScreen:
        return MaterialPageRoute<MapScreen>(
          builder: (_) => const MapScreen(),
        );
      default:
        return MaterialPageRoute<Object>(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No route'),
            ),
          ),
        );
    }
  }

  static void goToMap(BuildContext context) {
    Navigator.pushAndRemoveUntil<MapScreen>(
      context,
      MaterialPageRoute<MapScreen>(
        builder: (_) => const MapScreen(),
      ),
      ModalRoute.withName(mapScreen),
    );
  }

  static void goToSettings(BuildContext context) {
    Navigator.pushAndRemoveUntil<SettingsScreen>(
      context,
      MaterialPageRoute<SettingsScreen>(
        builder: (_) => SettingsScreen(themeProvider: themeProvider,),
      ),
      ModalRoute.withName(settingsScreen),
    );
  }

  static void goToSightList(BuildContext context) {
    Navigator.pushAndRemoveUntil<SightListScreen>(
      context,
      MaterialPageRoute<SightListScreen>(
        builder: (_) => const SightListScreen(),
      ),
      ModalRoute.withName(sightListScreen),
    );
  }

  static void goToVisiting(BuildContext context) {
    Navigator.pushAndRemoveUntil<FavoriteScreen>(
      context,
      MaterialPageRoute<FavoriteScreen>(
        builder: (_) => const FavoriteScreen(),
      ),
      ModalRoute.withName(visitingScreen),
    );
  }

  static void goToSightDetails(BuildContext context, Place searchResult) {
    Navigator.push<SightDetailsScreen>(
      context,
      MaterialPageRoute(
        builder: (_) => SightDetailsScreen(place: searchResult),
      ),
    );
  }

  static void goToOnBoarding(BuildContext context) {
    Navigator.pushAndRemoveUntil<OnBoardingScreen>(
      context,
      MaterialPageRoute<OnBoardingScreen>(
        builder: (_) => const OnBoardingScreen(),
      ),
      ModalRoute.withName(onBoardingScreen),
    );
  }

  static void goToCategories(
    BuildContext context,
    Function(String) updateSelectedCategory,
  ) {
    Navigator.push<NewPlaceCategory>(
      context,
      MaterialPageRoute(
        builder: (_) => NewPlaceCategory(
          updateSelectedCategory: updateSelectedCategory,
        ),
      ),
    );
  }

  static void goToFilter(BuildContext context) {
    Navigator.push<FiltersScreen>(
      context,
      MaterialPageRoute(
        builder: (_) => const FiltersScreen(),
      ),
    );
  }

  static void goToAddSight(
    BuildContext context,
      Point? point,
  ) {
    Navigator.push<AddSightScreen>(
      context,
      MaterialPageRoute(
        builder: (_) => AddSightScreen(point: point,),
      ),
    );
  }

  static void goToSightSearch(BuildContext context) {
    Navigator.push<SightSearchScreen>(
      context,
      MaterialPageRoute(
        builder: (_) => const SightSearchScreen(),
      ),
    );
  }
}
