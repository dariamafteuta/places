import 'package:flutter/material.dart';
import 'package:flutter_job/data/iterator/favorite_store.dart';
import 'package:flutter_job/data/iterator/visited_store.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/components/bottom_navigation_bar.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/visiting_screen/sight_card_plan.dart';
import 'package:flutter_job/ui/screens/visiting_screen/sight_card_visited.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
    final favoriteStore = Provider.of<FavoriteStore>(context, listen: false);
    final visitedStore = Provider.of<VisitedStore>(context, listen: false);

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
        body: Observer(
          builder: (_) {
            return TabBarView(
              children: [
                if (favoriteStore.favoritePlaces.isNotEmpty)
                  ReorderableListView(
                    onReorder: _onReorderPlan,
                    children: favoriteStore.favoritePlaces.map((place) {
                      return SightCardPlan(
                        ValueKey(place.id),
                        place,
                        removeFavoritePlace,
                        validateData,
                      );
                    }).toList(), // преобразование множества в список
                  )
                else if (favoriteStore.favoritePlaces.isEmpty)
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
                if (visitedStore.visitedPlaces.isNotEmpty)
                  ReorderableListView(
                    onReorder: _onReorderVisited,
                    children: visitedStore.visitedPlaces.map((place) {
                      return SightCardVisited(
                        ValueKey(place.id),
                        place,
                        removeVisitedPlace,
                      );
                    }).toList(),
                  )
                else if (visitedStore.visitedPlaces.isEmpty)
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
            );
          },
        ),
      ),
    );
  }

  void validateData(Place place) {
    final favoriteStore = Provider.of<FavoriteStore>(context, listen: false);
    final visitedStore = Provider.of<VisitedStore>(context, listen: false);

    if (favoriteStore.dataVisited[place.id]?.isBefore(DateTime.now()) ??
        false) {
      favoriteStore.favoriteIdPlaces.remove(place.id);
      visitedStore.visitedIdPlaces.add(place.id);

      visitedStore.visitedPlaces.add(place);
    }
  }

  void removeFavoritePlace(Place place) {
    final favoriteStore = Provider.of<FavoriteStore>(context, listen: false);

    setState(() {
      favoriteStore.favoritePlaces.remove(place);
      favoriteStore.favoriteIdPlaces.remove(place.id);
      favoriteStore.dataVisited.remove(place.id);
    });
  }

  void removeVisitedPlace(Place place) {
    final favoriteStore = Provider.of<FavoriteStore>(context, listen: false);
    final visitedStore = Provider.of<VisitedStore>(context, listen: false);

    setState(() {
      visitedStore.visitedPlaces.remove(place);
      visitedStore.visitedIdPlaces.remove(place.id);
      favoriteStore.dataVisited.remove(place.id);
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
