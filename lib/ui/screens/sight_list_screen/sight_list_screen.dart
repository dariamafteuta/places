import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/components/bottom_navigation_bar.dart';
import 'package:flutter_job/domain/sight.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/mocks.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/screens/new_place_screen/add_sight_screen.dart';
import 'package:flutter_job/ui/screens/filters_screen.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_card.dart';
import 'package:flutter_job/ui/screens/sight_search_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

AppTypography appTypography = AppTypography();

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: themeProvider.appTheme.greenColor,
        highlightElevation: 0,
        onPressed: () {
          Navigator.push<SightListScreen>(
            context,
            MaterialPageRoute(
              builder: (context) => AddSightScreen(
                newSight: newSight,
              ),
            ),
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            elevation: 0,
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.all(16),
              title: Text(
                AppStrings.listOfInterestingPlaces,
                style: appTypography.text30Bold
                    .copyWith(color: themeProvider.appTheme.mainWhiteColor),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
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
                    hintStyle:
                        TextStyle(color: themeProvider.appTheme.inactiveColor),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        AppAssets.search,
                        color: themeProvider.appTheme.inactiveColor,
                      ),
                    ),
                    suffixIcon: CupertinoButton(
                      onPressed: () => Navigator.push<SightListScreen>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FiltersScreen(),
                        ),
                      ),
                      padding: EdgeInsets.zero,
                      child: SvgPicture.asset(
                        AppAssets.filter,
                        color: themeProvider.appTheme.greenColor,
                      ),
                    ),
                  ),
                  onTap: () => Navigator.push<SightListScreen>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SightSearchScreen(),
                    ),
                  ),
                ),
              ),
              ...mocks.map(
                (e) => SightCard(
                  sight: e,
                ),
              ),
            ]),
          ),
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
