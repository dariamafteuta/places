import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_list_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

AppTypography appTypography = AppTypography();

class OnBoardingScreen extends StatefulWidget {
  static String id = 'on_boarding_screen';
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          if (_currentIndex != 2)
            CupertinoButton(
              child: Text(
                AppStrings.skip,
                style: appTypography.textGreen18Bold.copyWith(
                  color: themeProvider.appTheme.greenColor,
                ),
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                children: [
                  Tutorial(
                    icon: AppAssets.tutorial1Frame,
                    tutorial: AppStrings.tutorial1,
                    tutorial1: AppStrings.tutorial1_1,
                  ),
                  Tutorial(
                    icon: AppAssets.tutorial2Frame,
                    tutorial: AppStrings.tutorial2,
                    tutorial1: AppStrings.tutorial2_1,
                  ),
                  Tutorial(
                    icon: AppAssets.tutorial3Frame,
                    tutorial: AppStrings.tutorial3,
                    tutorial1: AppStrings.tutorial3_1,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    radius: 8,
                    dotColor: themeProvider.appTheme.inactiveColor,
                    activeDotColor: themeProvider.appTheme.greenColor,
                  ),
                ),
                sizedBox32H,
                if (_currentIndex == 2)
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: TextButton(
                      child: Text(
                        AppStrings.start.toUpperCase(),
                        style: appTypography.text14Regular
                            .copyWith(color: themeProvider.appTheme.whiteColor),
                      ),
                      style: TextButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: themeProvider.appTheme.greenColor,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil<SightListScreen>(
                          context,
                          MaterialPageRoute<SightListScreen>(
                            builder: (_) => const SightListScreen(null),
                          ),
                          ModalRoute.withName(SightListScreen.id),
                        );
                      },
                    ),
                  )
                else
                  const SizedBox(
                    height: 48,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Tutorial extends StatelessWidget {
  final String icon;
  final String tutorial;
  final String tutorial1;

  const Tutorial({
    Key? key,
    required this.icon,
    required this.tutorial,
    required this.tutorial1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          sizedBox42H,
          SizedBox(
            height: 58,
            width: 244,
            child: Text(
              tutorial,
              style: appTypography.text24Bold
                  .copyWith(color: themeProvider.appTheme.mainWhiteColor),
              textAlign: TextAlign.center,
            ),
          ),
          sizedBox8H,
          SizedBox(
            height: 36,
            width: 244,
            child: Text(
              tutorial1,
              style: appTypography.text14Regular
                  .copyWith(color: themeProvider.appTheme.secondary2Color),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
