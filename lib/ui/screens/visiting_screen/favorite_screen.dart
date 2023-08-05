import 'package:drift/drift.dart' as dr;
import 'package:flutter/material.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/repository/place_repository.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/database/app_database.dart';
import 'package:flutter_job/ui/components/bottom_navigation.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/visiting_screen/sight_card_plan.dart';
import 'package:flutter_job/ui/screens/visiting_screen/sight_card_visited.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late AppDatabase appDatabase;

  Future<List<FavoriteListData>> _getFavoriteFromDb() async {
    return appDatabase.getMyFavoriteList();
  }

  Future<List<VisitedListData>> _getVisitedFromDb() async {
    return appDatabase.getMyVisitedList();
  }

  Future<void> _checkingForVisitedPlaces() async {
    final allFavorites = await appDatabase.getMyFavoriteList();

    for (final favorite in allFavorites) {
      if (favorite.selectedDate != null &&
          favorite.selectedDate!.isBefore(DateTime.now())) {
        await appDatabase.insertMyVisited(
          VisitedListCompanion(
            id: dr.Value(favorite.id),
            selectedDate: dr.Value(favorite.selectedDate),
          ),
        );
        await appDatabase.deleteMyFavorite(FavoriteListData(
          id: favorite.id,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    appDatabase = Provider.of<AppDatabase>(context);
    _checkingForVisitedPlaces();

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
              FutureBuilder<List<FavoriteListData>>(
                future: _getFavoriteFromDb(),
                builder: (_, snapshot) {
                  final favoriteList = snapshot.data;

                  return favoriteList != null && favoriteList.isNotEmpty
                      ? ListView.builder(
                          itemCount: favoriteList.length,
                          itemBuilder: (_, index) {
                            final favoriteData = favoriteList[index];

                            return FutureBuilder<Place>(
                              future:
                                  PlaceRepository().getPlaceId(favoriteData.id),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  final place = snapshot.data;

                                  return SightCardPlan(
                                    ValueKey(place?.id),
                                    onFavoriteDeleted: () {
                                      setState(() {
                                        favoriteList.removeAt(index);
                                      });
                                    },
                                    favoritePlace: place!,
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            );
                          },
                        )
                      : Center(
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
                        );
                },
              ),
              FutureBuilder<List<VisitedListData>>(
                future: _getVisitedFromDb(),
                builder: (_, snapshot) {
                  final visitedList = snapshot.data;

                  return visitedList != null && visitedList.isNotEmpty
                      ? ListView.builder(
                          itemCount: visitedList.length,
                          itemBuilder: (_, index) {
                            final visitedData = visitedList[index];

                            return FutureBuilder<Place>(
                              future:
                                  PlaceRepository().getPlaceId(visitedData.id),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  final place = snapshot.data;

                                  return SightCardVisited(
                                    ValueKey(place?.id),
                                    onVisitedDeleted: () {
                                      setState(() {
                                        visitedList.removeAt(index);
                                      });
                                    },
                                    visitedPlace: place!,
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            );
                          },
                        )
                      : Center(
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
                        );
                },
              ),
            ],
          ),
        ),
      );
  }
}
