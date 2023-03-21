import 'package:flutter/material.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/screens/settings_screen.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_list_screen.dart';
import 'package:flutter_job/ui/screens/visiting_screen/visiting_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatefulWidget {
  final int index;

  const BottomNavigation({
    Key? key, required this.index,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        if(index == 0) {
          Navigator.pushAndRemoveUntil<SightListScreen>(context,
            MaterialPageRoute<SightListScreen>(builder: (context) => const SightListScreen(null)),
            ModalRoute.withName(SightListScreen.id),
          );
        }
        if(index == 2) {
          Navigator.pushAndRemoveUntil<VisitingScreen>(context,
            MaterialPageRoute<VisitingScreen>(builder: (context) => const VisitingScreen()),
            ModalRoute.withName(VisitingScreen.id),
          );
        }
        if(index == 3) {
          Navigator.pushAndRemoveUntil<SettingsScreen>(context,
            MaterialPageRoute<SettingsScreen>(builder: (context) => SettingsScreen(themeProvider: themeProvider)),
            ModalRoute.withName(SettingsScreen.id),
          );
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
