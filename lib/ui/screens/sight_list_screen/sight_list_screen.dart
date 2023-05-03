import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/data/iterator/place_iterator.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/repository/place_repository.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/components/bottom_navigation_bar.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppTypography appTypography = AppTypography();
PlaceRepository placeRepository = PlaceRepository();

class SightListScreen extends StatefulWidget {
  final Future<List<Place>> places;

  const SightListScreen({
    Key? key,
    required this.places,
  }) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    final orientationPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      bottomNavigationBar: const BottomNavigation(index: 0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: themeProvider.appTheme.yellowAndGreenColor,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: themeProvider.appTheme.transparentColor,
          highlightElevation: 0,
          onPressed: () {
            AppNavigation.goToAddSight(
              context,
            );
          },
          icon: SvgPicture.asset(
            AppAssets.plus,
            color: themeProvider.appTheme.whiteColor,
          ),
          label: Text(
            AppStrings.newPlace.toUpperCase(),
            style: appTypography.text14Regular
                .copyWith(color: themeProvider.appTheme.whiteColor),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            elevation: 0,
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: orientationPortrait,
              titlePadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(
                AppStrings.listOfInterestingPlaces,
                style: appTypography.text30Bold
                    .copyWith(color: themeProvider.appTheme.mainWhiteColor),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: themeProvider.appTheme.backgroundColor,
                      filled: true,
                      hintText: AppStrings.search,
                      hintStyle: TextStyle(
                        color: themeProvider.appTheme.inactiveColor,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          AppAssets.search,
                          color: themeProvider.appTheme.inactiveColor,
                        ),
                      ),
                      suffixIcon: CupertinoButton(
                        onPressed: () => AppNavigation.goToFilter(context),
                        padding: EdgeInsets.zero,
                        child: SvgPicture.asset(
                          AppAssets.filter,
                          color: themeProvider.appTheme.greenColor,
                        ),
                      ),
                    ),
                    onTap: () => AppNavigation.goToSightSearch(context),
                  ),
                ),
              ],
            ),
          ),
          if (orientationPortrait)
            SightPortrait(
              places: widget.places,
            )
          else
            SightLandscape(
              places: widget.places,
            ),
        ],
      ),
    );
  }
}

PlaceIterator placeIterator = PlaceIterator();

class SightPortrait extends StatelessWidget {
  final Future<List<Place>> places;

  const SightPortrait({Key? key, required this.places}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Place>>(
      future: places,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final places = snapshot.data!;

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                final place = places[index];

                return SightCard(
                  ValueKey(place.id),
                  place,
                );
              },
              childCount: places.length,
            ),
          );
        } else if (snapshot.hasError) {
          return SliverFillRemaining(
            child: Center(
              child: Text('Ошибка: ${snapshot.error}'),
            ),
          );
        } else {
          return SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(
                color: themeProvider.appTheme.inactiveColor,
              ),
            ),
          );
        }
      },
    );
  }
}

class SightLandscape extends StatelessWidget {
  final Future<List<Place>> places;

  const SightLandscape({Key? key, required this.places}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 216,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: placeIterator.placeFromNet.length,
        (_, index) {
          return FutureBuilder<List<Place>>(
            future: places,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                final places = snapshot.data!;

                return SightCard(
                  ValueKey(places[index].id),
                  places[index],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Ошибка: ${snapshot.error}'),
                );
              } else {
                return CircularProgressIndicator(
                  color: themeProvider.appTheme.inactiveColor,
                );
              }
            },
          );
        },
      ),
    );
  }
}
