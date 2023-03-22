import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/components/bottom_sheet_details.dart';
import 'package:flutter_job/components/card_delete_background.dart';
import 'package:flutter_job/domain/sight.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/screens/visiting_screen/visiting_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SightCardPlan extends StatefulWidget {
  final Sight sight;
  final Function(Sight) planRemoveSight;

  const SightCardPlan(
    Key? key,
    this.sight,
    this.planRemoveSight,
  ) : super(key: key);

  @override
  State<SightCardPlan> createState() => _SightCardPlanState();
}

AppTypography appTypography = AppTypography();

class _SightCardPlanState extends State<SightCardPlan> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: InkWell(
        onTap: () {
          showModalBottomSheet<VisitingScreen>(
            isScrollControlled: true,
            isDismissible: false,
            context: context,
            backgroundColor: themeProvider.appTheme.transparentColor,
            builder: (_) {
              return BottomSheetDetails(
                sight: widget.sight,
              );
            },
          );
        },
        splashColor: themeProvider.appTheme.whiteMainColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() {
              widget.planRemoveSight(widget.sight);
            });
          },
          background: const CardDeleteBackground(),
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
                      child: Ink(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.sight.url.isNotEmpty
                                  ? widget.sight.url[0]
                                  : 'https://www.sirvisual.com/Attachment/100/5055_31356_420%20Principale.jpg',
                            ),
                            fit: BoxFit.fitWidth,
                          ),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                        ),
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
                            AppAssets.calendar,
                            color: themeProvider.appTheme.whiteColor,
                          ),
                          onPressed: () {},
                        ),
                        CupertinoButton(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            AppAssets.close,
                            color: themeProvider.appTheme.whiteColor,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.planRemoveSight(widget.sight);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Text(
                      widget.sight.type,
                      style: appTypography.text14w700.copyWith(
                        color: themeProvider.appTheme.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
              Ink(
                decoration: BoxDecoration(
                  color: themeProvider.appTheme.backgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
                height: 100,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.sight.name,
                        style: appTypography.text16Bold.copyWith(
                          color: themeProvider.appTheme.secondaryWhiteColor,
                        ),
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
                        'Запланировано на 12 окт. 2022',
                        style: appTypography.text14Regular
                            .copyWith(color: themeProvider.appTheme.greenColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
