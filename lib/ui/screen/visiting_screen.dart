import 'package:flutter/material.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_colors.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/screen/sight_card_plan.dart';
import 'package:flutter_job/ui/screen/sight_card_visited.dart';
import 'package:flutter_job/mocks.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  final plan_mocks = [];
  final completed_mocks = [mocks[0], mocks[2]];

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
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Material(
                color: AppColors.lightGrayColor,
                borderRadius: BorderRadius.circular(100),
                child: TabBar(
                  unselectedLabelColor: AppColors.greyColor,
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: AppColors.titleColor,
                    borderRadius: BorderRadius.circular(100),
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
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: AppColors.greyColor,
          selectedItemColor: AppColors.titleColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 2,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded),
              label: 'list',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_rounded),
              label: 'map',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outlined,
              ),
              label: 'favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'settings',
            ),
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            if (plan_mocks.isNotEmpty)
              SingleChildScrollView(
                child: Column(
                  children: List.generate(plan_mocks.length, (index) {
                    return SightCardPlan(
                      sight: plan_mocks[index],
                    );
                  }),
                ),
              )
            else
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.camera,
                      height: 100,
                      width: 100,
                      color: AppColors.greyColor,
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    const Text(
                      AppStrings.blank,
                      style: AppTypography.textGrey17Bold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      AppStrings.favoritesPlace,
                      style: AppTypography.textGrey14Regular,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            if (completed_mocks.isNotEmpty)
              SingleChildScrollView(
                child: Column(
                  children: List.generate(completed_mocks.length, (index) {
                    return SightCardVisited(
                      sight: completed_mocks[index],
                    );
                  }),
                ),
              )
            else
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.navigator,
                      height: 90,
                      width: 90,
                      color: AppColors.greyColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      AppStrings.blank,
                      style: AppTypography.textGrey17Bold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      AppStrings.completedRoute,
                      style: AppTypography.textGrey14Regular,
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
