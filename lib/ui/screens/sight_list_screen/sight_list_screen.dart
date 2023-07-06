import 'package:capped_progress_indicator/capped_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job/bloc/places_bloc/places_bloc.dart';
import 'package:flutter_job/bloc/places_bloc/places_event.dart';
import 'package:flutter_job/bloc/places_bloc/places_state.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/data/store/places_store_base.dart';
import 'package:flutter_job/ui/components/bottom_navigation.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/filters_screen.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SightListScreen extends StatefulWidget {
  final List<String>? type;

  const SightListScreen({
    Key? key, required this.type,
  }) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  final inactiveColor = themeProvider.appTheme.inactiveColor;
  final whiteColor = themeProvider.appTheme.whiteColor;

  late PlacesBloc placesBloc;

  @override
  void initState() {
    super.initState();
    placesBloc = PlacesBloc(Provider.of<PlacesStore>(context, listen: false),
        radius: RangeValues(start, end), type: widget.type,);
  }

  @override
  void dispose() {
    placesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientationPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return MultiBlocProvider(
      providers: [
        BlocProvider<PlacesBloc>(
          create: (_) => placesBloc..add(FetchPlaces()),
        ),
      ],
      child: Scaffold(
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
              const SightPortrait()
            else
              const SightLandscape(),
          ],
        ),
      ),
    );
  }
}

class SightPortrait extends StatelessWidget {
  const SightPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (_, state) {
        if (state is PlacesLoading) {
          return circularProgress;
        } else if (state is PlacesLoaded) {
          return placeFromNet.isNotEmpty
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      final place = placeFromNet[index];

                      return SightCard(
                        ValueKey(place.id),
                        place,
                      );
                    },
                    childCount: placeFromNet.length,
                  ),
                )
              : const SizedBox.shrink();
        } else {
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
        }
      },
    );
  }
}

class SightLandscape extends StatelessWidget {
  const SightLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (_, state) {
        if (state is PlacesLoading) {
          return circularProgress;
        } else if (state is PlacesLoaded) {
          return SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 216,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: placeFromNet.length,
              (_, index) {
                final place = placeFromNet[index];

                return SightCard(
                  ValueKey(place.id),
                  place,
                );
              },
            ),
          );
        } else {
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
        }
      },
    );
  }
}
