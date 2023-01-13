import 'package:flutter/cupertino.dart';
import 'package:flutter_job/domain/sight.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_colors.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SightCardVisited extends StatelessWidget {
  final Sight? sight;

  const SightCardVisited({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    child: Image.network(
                      sight!.url,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : const CupertinoActivityIndicator(),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    right: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        AppAssets.share,
                        color: AppColors.whiteColor,
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset(
                        AppAssets.close,
                        color: AppColors.whiteColor,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Text(
                    sight!.type,
                    style: AppTypography.text14w700,
                  ),
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                color: !isDarkTheme ? AppColors.ltBackgroundColor : AppColors.dtDarkColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              height: 100,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      sight!.name,
                      style: AppTypography.text16Bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 5,
                      right: 16,
                    ),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Цель достигнута 12 окт. 2022',
                      style: AppTypography.textGreyInactive14Regular,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
