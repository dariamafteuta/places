import 'package:flutter/material.dart';
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

class _VisitingScreenState extends State<VisitingScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final planMocks = [mocks[0]];
  final visitedMocks = [mocks[1]];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0.0,
          title: const Center(
            child: Text(
              AppStrings.favorites,
              style: AppTypography.textTitle24Bold,
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
                color: AppColors.lightGrayColor,
                borderRadius: BorderRadius.circular(40),
                child: TabBar(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                  unselectedLabelColor: AppColors.greyInactiveColor,
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: AppColors.titleColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  tabs: const [
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
        bottomNavigationBar: Theme(
          data: ThemeData(canvasColor: AppColors.whiteColor),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.list,
                  color: _selectedIndex == 0
                      ? AppColors.titleColor
                      : AppColors.textColor,
                ),
                label: 'list',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.map,
                  color: _selectedIndex == 1
                      ? AppColors.titleColor
                      : AppColors.textColor,
                ),
                label: 'map',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.heartFull,
                  color: _selectedIndex == 2
                      ? AppColors.titleColor
                      : AppColors.textColor,
                ),
                label: 'favorite',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.settings,
                  color: _selectedIndex == 3
                      ? AppColors.titleColor
                      : AppColors.textColor,
                ),
                label: 'settings',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
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
                      color: AppColors.greyColor,
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
                      color: AppColors.greyColor,
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
