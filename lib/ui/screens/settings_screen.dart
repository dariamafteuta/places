import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/components/bottom_navigation_bar.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppTypography appTypography = AppTypography();

class SettingsScreen extends StatefulWidget {
  final ThemeProvider themeProvider;

  const SettingsScreen({
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: Text(
            AppStrings.settings,
            style: appTypography.text24Bold.copyWith(
              color: themeProvider.appTheme.mainWhiteColor,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        index: 3,
        themeProvider: themeProvider,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.darkTheme,
                  style: appTypography.text14Regular.copyWith(
                    fontSize: 18,
                    color: themeProvider.appTheme.secondaryWhiteColor,
                  ),
                ),
                CupertinoSwitch(
                  value: !widget.themeProvider.isLightTheme,
                  onChanged: (value) {
                    widget.themeProvider.isLightTheme = !value;
                  },
                ),
              ],
            ),
            divider,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    AppNavigation.goToOnBoarding(context);
                  },
                  child: Text(
                    AppStrings.watchTutorial,
                    style: appTypography.text14Regular.copyWith(
                      fontSize: 18,
                      color: themeProvider.appTheme.secondaryWhiteColor,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  AppAssets.info,
                  color: widget.themeProvider.appTheme.greenColor,
                ),
              ],
            ),
            divider,
          ],
        ),
      ),
    );
  }
}
