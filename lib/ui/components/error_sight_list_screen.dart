import 'package:flutter/cupertino.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_svg/svg.dart';

class ErrorSightListScreen extends StatelessWidget {
  const ErrorSightListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.group_5922EmptyPage),
          sizedBox24H,
          Text(
            AppStrings.error,
            style: appTypography.textGreyInactive18Bold,
            textAlign: TextAlign.center,
          ),
          sizedBox8H,
          Text(
            AppStrings.errorTut,
            style: appTypography.textGreyInactive14Regular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
