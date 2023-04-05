import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/components/bottom_navigation_bar.dart';
import 'package:flutter_job/domain/sight.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/mocks.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppTypography appTypography = AppTypography();

class SightListScreen extends StatefulWidget {
  final Iterable<Sight>? sight;

  const SightListScreen(this.sight, {Key? key}) : super(key: key);

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
            AppNavigation.goToAddSight(context, newSight);
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
            SightPortrait(sight: widget.sight)
          else
            SightLandscape(sight: widget.sight),
        ],
      ),
    );
  }

  void newSight(Sight sight) {
    setState(() {
      mocks.add(sight);
    });
  }
}

class SightPortrait extends StatelessWidget {
  final Iterable<Sight>? sight;

  const SightPortrait({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 1,
        (context, index) {
          return Column(
            children: [
              if (sight == null)
                ...mocks.map(
                  (e) => SightCard(UniqueKey(), e),
                )
              else
                ...?sight?.map(
                  (e) => SightCard(UniqueKey(), e),
                ),
            ],
          );
        },
      ),
    );
  }
}

class SightLandscape extends StatelessWidget {
  final Iterable<Sight>? sight;

  const SightLandscape({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 216,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: sight == null ? mocks.length : sight?.length,
        (_, index) {
          return sight == null
              ? SightCard(UniqueKey(), mocks[index])
              : SightCard(UniqueKey(), sight!.toList()[index]);
        },
      ),
    );
  }
}
