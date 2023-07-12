import 'package:flutter/cupertino.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_svg/svg.dart';

class CardDeleteBackground extends StatelessWidget {
  const CardDeleteBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final whiteColor = themeProvider.appTheme.whiteColor;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: themeProvider.appTheme.redColor,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.bucket,
                color: whiteColor,
              ),
              sizedBox10H,
              Text(
                AppStrings.delete,
                style: appTypography.text14Bold.copyWith(
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
