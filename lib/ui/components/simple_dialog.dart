import 'package:flutter/material.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/filters_screen.dart';
import 'package:flutter_svg/svg.dart';

class SimpleDialogWrapper extends StatelessWidget {
  const SimpleDialogWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
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
    );
  }
}