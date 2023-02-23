import 'package:flutter/material.dart';
import 'package:flutter_job/components/bottom_navigation_bar.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/mocks.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/sight_card_plan.dart';
import 'package:flutter_job/ui/screens/sight_card_visited.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_job/domain/sight.dart';

AppTypography appTypography = AppTypography();

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  final _planMocks = [mocks[0], mocks[3], mocks[2], mocks[5]];
  final _visitedMocks = [mocks[7], mocks[4], mocks[1]];

  @override
  Widget build(BuildContext context) {
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
        bottomNavigationBar: const BottomNavigation(),
        body: TabBarView(
          children: [
            if (_planMocks.isNotEmpty)
              SingleChildScrollView(
                child: Column(
                  children: List.generate(_planMocks.length, (index) {
                    return SightCardPlan(
                      sight: _planMocks[index],
                      planRemoveSight: planRemoveSight,
                    );
                  }),
                ),
              )
            else
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.cardEmptyPage,
                    ),
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
            if (_visitedMocks.isNotEmpty)
              SingleChildScrollView(
                child: Column(
                  children: List.generate(_visitedMocks.length, (index) {
                    return SightCardVisited(
                      sight: _visitedMocks[index],
                      visitedRemoveSight: visitedRemoveSight,
                    );
                  }),
                ),
              )
            else
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.goEmptyPage,
                    ),
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

  void visitedRemoveSight(Sight sight) {
    setState(() {
      _visitedMocks.remove(sight);
    });
  }

  void planRemoveSight(Sight sight) {
    setState(() {
      _planMocks.remove(sight);
    });
  }
}
