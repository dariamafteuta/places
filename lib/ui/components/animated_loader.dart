import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/ui/res/app_assets.dart';

class AnimatedLoader extends StatefulWidget {
  const AnimatedLoader({Key? key}) : super(key: key);

  @override
  State<AnimatedLoader> createState() => _AnimatedLoaderState();
}

class _AnimatedLoaderState extends State<AnimatedLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: AnimatedBuilder(
        animation: _animationController,
        child: Image.asset(
          themeProvider.isLightTheme
              ? AppAssets.whiteSmallLoader
              : AppAssets.blackSmallLoader,
          height: 40,
          width: 40,
        ),
        builder: (context, child) {
          return Transform.rotate(
            angle: _animationController.value * 2 * -pi,
            child: child,
          );
        },
      ),
    );
  }
}
