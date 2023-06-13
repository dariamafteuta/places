import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/ui/components/bottom_navigation.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final inactiveColor = themeProvider.appTheme.inactiveColor;
  final whiteColor = themeProvider.appTheme.whiteColor;

  @override
  Widget build(BuildContext context) {
    final orientationPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      bottomNavigationBar: const BottomNavigation(index: 0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: DecoratedBox(
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
            color: whiteColor,
          ),
          label: Text(
            AppStrings.newPlace.toUpperCase(),
            style: appTypography.text14Regular.copyWith(color: whiteColor),
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
                        color: inactiveColor,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          AppAssets.search,
                          color: inactiveColor,
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
              placesStream: Stream.fromFuture(widget.places),
            )
          else
            SightLandscape(
              placesStream: Stream.fromFuture(widget.places),
            ),
        ],
      ),
    );
  }
}

class SightPortrait extends StatelessWidget {
  final Stream<List<Place>> placesStream;

  const SightPortrait({Key? key, required this.placesStream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Place>>(
      stream: placesStream,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssets.group_5922EmptyPage),
                sizedBox24H,
                Text(
                  AppStrings.error,
                  style: appTypography.textGreyInactive18Bold,
                  textAlign: TextAlign.center,
                ),
                sizedBox8H,
                Text(
                  AppStrings.errorTut,
                  style: appTypography.textGreyInactive14Regular,
                  textAlign: TextAlign.center,
                ),
              ],
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
  final Stream<List<Place>> placesStream;

  const SightLandscape({Key? key, required this.placesStream})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Place>>(
      stream: placesStream.distinct(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final places = snapshot.data!;

          return SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 216,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: places.length,
              (_, index) {
                final place = places[index];

                return SightCard(
                  ValueKey(place.id),
                  place,
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssets.group_5922EmptyPage),
                sizedBox24H,
                Text(
                  AppStrings.error,
                  style: appTypography.textGreyInactive18Bold,
                  textAlign: TextAlign.center,
                ),
                sizedBox8H,
                Text(
                  AppStrings.errorTut,
                  style: appTypography.textGreyInactive14Regular,
                  textAlign: TextAlign.center,
                ),
              ],
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
