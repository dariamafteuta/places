import 'package:flutter/material.dart';
import 'package:flutter_job/domain/sight.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/theme_provider.dart';
import 'package:flutter_job/ui/screens/filters_screen.dart';
import 'package:flutter_job/ui/screens/new_place_screen/add_sight_screen.dart';
import 'package:flutter_job/ui/screens/new_place_screen/new_place_category.dart';
import 'package:flutter_job/ui/screens/on_boarding_screen.dart';
import 'package:flutter_job/ui/screens/settings_screen.dart';
import 'package:flutter_job/ui/screens/sight_details_screen/sight_details_screen.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_list_screen.dart';
import 'package:flutter_job/ui/screens/sight_search_screen.dart';
import 'package:flutter_job/ui/screens/splash_screen.dart';
import 'package:flutter_job/ui/screens/visiting_screen/visiting_screen.dart';

class AppNavigation {
  static const String splashScreen = '/splash_screen';
  static const String onBoardingScreen = '/on_boarding_screen';
  static const String sightListScreen = '/sight_list_screen';
  static const String visitingScreen = '/visiting_screen';
  static const String settingsScreen = '/settings_screen';
  static const String sightSearchScreen = '/sight_search_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute<SplashScreen>(builder: (_) => const SplashScreen());
      case onBoardingScreen:
        return MaterialPageRoute<OnBoardingScreen>(
          builder: (_) => const OnBoardingScreen(),
        );
      case sightListScreen:
        return MaterialPageRoute<SightListScreen>(
          builder: (_) => const SightListScreen(null),
        );
      case visitingScreen:
        return MaterialPageRoute<VisitingScreen>(
          builder: (_) => const VisitingScreen(),
        );
      case settingsScreen:
        return MaterialPageRoute<SettingsScreen>(
          builder: (_) => SettingsScreen(themeProvider: themeProvider),
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

  static void goToSettings(BuildContext context, ThemeProvider themeProvider) {
    Navigator.pushAndRemoveUntil<SettingsScreen>(
      context,
      MaterialPageRoute<SettingsScreen>(
        builder: (_) => SettingsScreen(themeProvider: themeProvider),
      ),
      ModalRoute.withName(settingsScreen),
    );
  }

  static void goToSightList(BuildContext context, Iterable<Sight>? sight) {
    Navigator.pushAndRemoveUntil<SightListScreen>(
      context,
      MaterialPageRoute<SightListScreen>(
        builder: (_) => SightListScreen(sight),
      ),
      ModalRoute.withName(sightListScreen),
    );
  }

  static void goToVisiting(BuildContext context) {
    Navigator.pushAndRemoveUntil<VisitingScreen>(
      context,
      MaterialPageRoute<VisitingScreen>(
        builder: (_) => const VisitingScreen(),
      ),
      ModalRoute.withName(visitingScreen),
    );
  }

  static void goToSightDetails(BuildContext context, Sight searchResult) {
    Navigator.push<SightDetailsScreen>(
      context,
      MaterialPageRoute(
        builder: (_) => SightDetailsScreen(sight: searchResult),
      ),
    );
  }

  static void goToOnBoarding(BuildContext context) {
    Navigator.push<OnBoardingScreen>(
      context,
      MaterialPageRoute(
        builder: (_) => const OnBoardingScreen(),
      ),
    );
  }

  static void goToCategories(
    BuildContext context,
    Function(String) updateSelectedCategory,
  ) {
    Navigator.push<Categories>(
      context,
      MaterialPageRoute(
        builder: (_) => Categories(
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

  static void goToAddSight(BuildContext context, Function(Sight) newSight) {
    Navigator.push<AddSightScreen>(
      context,
      MaterialPageRoute(
        builder: (_) => AddSightScreen(
          newSight: newSight,
        ),
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
