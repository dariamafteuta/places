import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;

  static const String _navigateKey = 'navigateToOnBoarding';
  bool onBoardingStatus = false;


  @override
  void initState() {
    _navigateToNext();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = Tween<double>(begin: 0, end: -pi * 2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.decelerate),
    );

    _animationController
      ..forward()
      ..repeat();

    _loadOnBoardingStatus();
    super.initState();
  }

  Future<void> _loadOnBoardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    onBoardingStatus = prefs.getBool(_navigateKey) ?? false;
  }

  Future<void> _saveOnBoardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_navigateKey, onBoardingStatus);
  }

  Future<void> _navigateToNext() async {
    final isInitialized =
        await Future<bool>.delayed(const Duration(seconds: 2), () => true);
    if (isInitialized) {
      _navigation();
    } else {
      debugPrint('Ошибка');
    }
  }

  void _navigation() {
    if (!onBoardingStatus) {
      AppNavigation.goToOnBoarding(context);
      onBoardingStatus = true;
      _saveOnBoardingStatus();
    } else {
      AppNavigation.goToSightList(context);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _saveOnBoardingStatus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: themeProvider.appTheme.yellowAndGreenColor,
        ),
      ),
      child: AnimatedBuilder(
        animation: animation,
        child: Center(
          child: SvgPicture.asset(
            AppAssets.iconSplash,
            height: 160,
            width: 160,
          ),
        ),
        builder: (_, child) => Transform.rotate(
          angle: animation.value,
          child: child,
        ),
      ),
    );
  }
}
