import 'package:flutter/material.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatefulWidget {
  final int index;

  const BottomNavigation({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        if (index == 0) {
          AppNavigation.goToSightList(context, null);
        }
        if (index == 2) {
          AppNavigation.goToVisiting(context);
        }
        if (index == 3) {
          AppNavigation.goToSettings(context, themeProvider);
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            widget.index == 0 ? AppAssets.listFull : AppAssets.list,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          label: 'list',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            widget.index == 1 ? AppAssets.mapFull : AppAssets.map,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          label: 'map',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            widget.index == 2 ? AppAssets.heartFull : AppAssets.heart,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          label: 'favorite',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            widget.index == 3 ? AppAssets.settingsFull : AppAssets.settings,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          label: 'settings',
        ),
      ],
    );
  }
}
