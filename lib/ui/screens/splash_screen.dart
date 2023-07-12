import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;

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

    super.initState();
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
    AppNavigation.goToOnBoarding(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
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
