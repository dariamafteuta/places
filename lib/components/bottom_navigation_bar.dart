// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/screen/sight_list_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatefulWidget {
  int selectedIndex;

  BottomNavigation({Key? key, required this.selectedIndex,}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: (index) {
        setState(() {
          widget.selectedIndex = index;
        });
      },
      items: [

        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            widget.selectedIndex == 0 ? AppAssets.listFull : AppAssets.list,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          label: 'list',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            widget.selectedIndex == 1 ? AppAssets.mapFull : AppAssets.map,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          label: 'map',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            widget.selectedIndex == 2 ? AppAssets.heartFull : AppAssets.heart,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          label: 'favorite',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            widget.selectedIndex == 3
                ? AppAssets.settingsFull
                : AppAssets.settings,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          label: 'settings',
        ),
      ],
    );
  }
}
