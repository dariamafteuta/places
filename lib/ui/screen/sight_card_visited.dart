import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/domain/sight.dart';
import 'package:flutter_job/theme_provider.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SightCardVisited extends StatefulWidget {
  final Sight? sight;

 const SightCardVisited({Key? key, required this.sight}) : super(key: key);

  @override
  State<SightCardVisited> createState() => _SightCardVisitedState();
}

ThemeProvider themeProvider = ThemeProvider();
AppTypography appTypography = AppTypography();

class _SightCardVisitedState extends State<SightCardVisited> {

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
                      widget.sight!.url,
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
                    top: 5,
                    right: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CupertinoButton(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          AppAssets.share,
                          color: themeProvider.appTheme.whiteColor,
                        ),
                        onPressed: () { if (kDebugMode) {
                          print('Share Pressed');
                        } },
                      ),CupertinoButton(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          AppAssets.close,
                          color: themeProvider.appTheme.whiteColor,
                        ),
                        onPressed: () { if (kDebugMode) {
                          print('Close Pressed');
                        } },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Text(
                    widget.sight!.type,
                    style: appTypography.text14w700,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: themeProvider.appTheme.backgroundColor,
                borderRadius: const BorderRadius.vertical(
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
                      widget.sight!.name,
                      style: appTypography.text16Bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 5,
                      right: 16,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Цель достигнута 12 окт. 2022',
                      style: appTypography.textGreyInactive14Regular,
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
