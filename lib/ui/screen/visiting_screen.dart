import 'package:flutter/material.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/mocks.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_colors.dart';
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

class _VisitingScreenState extends State<VisitingScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final planMocks = [mocks[0]];
  final visitedMocks = [mocks[0]];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Center(
            child: Text(
              AppStrings.favorites,
              style: AppTypography.text24Bold,
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
                color: !isDarkTheme ? AppColors.ltBackgroundColor : AppColors.dtDarkColor,
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 0 ? AppAssets.listFull : AppAssets.list,
                color: !isDarkTheme ? AppColors.ltMainColor : AppColors.whiteColor,
              ),
              label: 'list',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 1 ? AppAssets.mapFull : AppAssets.map,
                color: !isDarkTheme ? AppColors.ltMainColor : AppColors.whiteColor,
              ),
              label: 'map',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 2 ? AppAssets.heartFull : AppAssets.heart,
                color: !isDarkTheme ? AppColors.ltMainColor : AppColors.whiteColor,
              ),
              label: 'favorite',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 3
                    ? AppAssets.settingsFull
                    : AppAssets.settings,
                color: !isDarkTheme ? AppColors.ltMainColor : AppColors.whiteColor,
              ),
              label: 'settings',
            ),
          ],
        ),
        body: TabBarView(
          children: [
            if (planMocks.isNotEmpty)
              SingleChildScrollView(
                child: Column(
                  children: List.generate(planMocks.length, (index) {
                    return SightCardPlan(
                      sight: planMocks[index],
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
                      color: AppColors.secondary2Color,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Text(
                      AppStrings.blank,
                      style: AppTypography.textGreyInactive18Bold,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      AppStrings.favoritesPlace,
                      style: AppTypography.textGreyInactive14Regular,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            if (visitedMocks.isNotEmpty)
              SingleChildScrollView(
                child: Column(
                  children: List.generate(visitedMocks.length, (index) {
                    return SightCardVisited(
                      sight: visitedMocks[index],
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
                      color: AppColors.secondary2Color,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Text(
                      AppStrings.blank,
                      style: AppTypography.textGreyInactive18Bold,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      AppStrings.completedRoute,
                      style: AppTypography.textGreyInactive14Regular,
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
