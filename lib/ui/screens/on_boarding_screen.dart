import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final orientationPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final greenColor = themeProvider.appTheme.greenColor;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          if (_currentIndex != 2)
            CupertinoButton(
              child: Text(
                AppStrings.skip,
                style: appTypography.textGreen18Bold.copyWith(
                  color: greenColor,
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
                    activeDotColor: greenColor,
                  ),
                ),
                if (orientationPortrait) sizedBox32H else sizedBox12H,
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
                        backgroundColor: greenColor,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        AppNavigation.goToSightList(
                          context,
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

class Tutorial extends StatefulWidget {
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
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> animation;

  final mainWhiteColor = themeProvider.appTheme.mainWhiteColor;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, lowerBound: 0.1, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 144).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _animationController,
              builder: (_, child) {
                return Opacity(
                  opacity: _animationController.value,
                  child: GestureDetector(
                    child: SvgPicture.asset(
                      widget.icon,
                      color: mainWhiteColor,
                      width: animation.value,
                      height: animation.value,
                    ),
                  ),
                );
              }),
          sizedBox42H,
          SizedBox(
            height: 58,
            width: 244,
            child: Text(
              widget.tutorial,
              style: appTypography.text24Bold.copyWith(color: mainWhiteColor),
              textAlign: TextAlign.center,
            ),
          ),
          sizedBox8H,
          SizedBox(
            height: 36,
            width: 244,
            child: Text(
              widget.tutorial1,
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
