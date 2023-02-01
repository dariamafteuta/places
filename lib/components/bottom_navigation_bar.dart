import 'package:flutter/material.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  void initState() {
    themeProvider.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    themeProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _selectedIndex == 0 ? AppAssets.listFull : AppAssets.list,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          label: 'list',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _selectedIndex == 1 ? AppAssets.mapFull : AppAssets.map,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          label: 'map',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _selectedIndex == 2 ? AppAssets.heartFull : AppAssets.heart,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          label: 'favorite',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _selectedIndex == 3 ? AppAssets.settingsFull : AppAssets.settings,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          label: 'settings',
        ),
      ],
    );
  }
}
