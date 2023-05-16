import 'package:flutter/material.dart';
import 'package:flutter_job/data/iterator/favorite_provider.dart';
import 'package:flutter_job/data/iterator/visited_provider.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/components/bottom_navigation_bar.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/visiting_screen/sight_card_plan.dart';
import 'package:flutter_job/ui/screens/visiting_screen/sight_card_visited.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

AppTypography appTypography = AppTypography();

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(
      context,
      listen: false,
    );
    final visitedProvider = Provider.of<VisitedProvider>(
      context,
      listen: false,
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Center(
            child: Text(
              AppStrings.favorites,
              style: appTypography.text24Bold.copyWith(
                color: themeProvider.appTheme.mainWhiteColor,
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Material(
                color: themeProvider.appTheme.backgroundColor,
                borderRadius: BorderRadius.circular(40),
                child: const TabBar(
                  tabs: [
                    Tab(
                      text: AppStrings.iWantToVisit,
                    ),
                    Tab(
                      text: AppStrings.visited,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          index: 2,
          themeProvider: themeProvider,
        ),
        body: TabBarView(
          children: [
            if (favoriteProvider.favoritePlaces.isNotEmpty)
              ReorderableListView(
                onReorder: _onReorderPlan,
                children: favoriteProvider.favoritePlaces.map((place) {
                  return SightCardPlan(
                    ValueKey(place.id),
                    place,
                    removeFavoritePlace,
                    validateData,
                  );
                }).toList(), // преобразование множества в список
              )
            else if (favoriteProvider.favoritePlaces.isEmpty)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.cardEmptyPage),
                    sizedBox32H,
                    Text(
                      AppStrings.blank,
                      style: appTypography.textGreyInactive18Bold,
                    ),
                    sizedBox8H,
                    Text(
                      AppStrings.favoritesPlace,
                      style: appTypography.textGreyInactive14Regular,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            if (visitedProvider.visitedPlaces.isNotEmpty)
              ReorderableListView(
                onReorder: _onReorderVisited,
                children: visitedProvider.visitedPlaces.map((place) {
                  return SightCardVisited(
                    ValueKey(place.id),
                    place,
                    removeVisitedPlace,
                  );
                }).toList(),
              )
            else if (visitedProvider.visitedPlaces.isEmpty)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.goEmptyPage),
                    sizedBox32H,
                    Text(
                      AppStrings.blank,
                      style: appTypography.textGreyInactive18Bold,
                    ),
                    sizedBox8H,
                    Text(
                      AppStrings.completedRoute,
                      style: appTypography.textGreyInactive14Regular,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void validateData(Place place) {
    final favoriteProvider = Provider.of<FavoriteProvider>(
      context,
      listen: false,
    );
    final visitedProvider = Provider.of<VisitedProvider>(
      context,
      listen: false,
    );

    if (favoriteProvider.dataVisited[place.id]?.isBefore(DateTime.now()) ??
        false) {
      favoriteProvider.favoriteIdPlaces.remove(place.id);
      visitedProvider.visitedIdPlaces.add(place.id);

      visitedProvider.visitedPlaces.add(place);
    }
  }

  void removeFavoritePlace(Place place) {
    final favoriteProvider = Provider.of<FavoriteProvider>(
      context,
      listen: false,
    );

    setState(() {
      favoriteProvider.favoritePlaces.remove(place);
      favoriteProvider.favoriteIdPlaces.remove(place.id);
      favoriteProvider.dataVisited.remove(place.id);
    });
  }

  void removeVisitedPlace(Place place) {
    final visitedProvider = Provider.of<VisitedProvider>(
      context,
      listen: false,
    );
    final favoriteProvider = Provider.of<FavoriteProvider>(
      context,
      listen: false,
    );

    setState(() {
      visitedProvider.visitedPlaces.remove(place);
      visitedProvider.visitedIdPlaces.remove(place.id);
      favoriteProvider.dataVisited.remove(place.id);
    });
  }

  void _onReorderVisited(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
    });
  }

  void _onReorderPlan(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
    });
  }
}
