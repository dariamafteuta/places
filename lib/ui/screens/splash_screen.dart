import 'package:flutter/material.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/screens/on_boarding_screen.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToNext();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: themeProvider.appTheme.yellowAndGreenColor,
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          AppAssets.iconSplash,
          height: 160,
          width: 160,
        ),
      ),
    );
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
    Navigator.pushNamed(context, OnBoardingScreen.id);
  }
}
