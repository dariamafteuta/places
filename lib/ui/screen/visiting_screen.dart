import 'package:flutter/material.dart';
import 'package:flutter_job/components/bottom_navigation_bar.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/mocks.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/screen/sight_card_plan.dart';
import 'package:flutter_job/ui/screen/sight_card_visited.dart';
import 'package:flutter_svg/svg.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

AppTypography appTypography = AppTypography();


class _VisitingScreenState extends State<VisitingScreen> {

  final _planMocks = [mocks[0]];
  final _visitedMocks = [mocks[7]];

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
              style: appTypography.text24Bold.copyWith(color: themeProvider.appTheme.mainWhiteColor,),
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
        bottomNavigationBar: BottomNavigation(selectedIndex: 2),
        body: TabBarView(
          children: [
            if (_planMocks.isNotEmpty)
              SingleChildScrollView(
                child: Column(
                  children: List.generate(_planMocks.length, (index) {
                    return SightCardPlan(
                      sight: _planMocks[index],
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
                      color: themeProvider.appTheme.secondary2Color,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      AppStrings.blank,
                      style: appTypography.textGreyInactive18Bold,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
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
                      color: themeProvider.appTheme.secondary2Color,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      AppStrings.blank,
                      style: appTypography.textGreyInactive18Bold,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
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
}
