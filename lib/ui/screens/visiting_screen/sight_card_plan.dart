import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/translate_type.dart';
import 'package:flutter_job/ui/components/card_delete_background.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/screens/sight_details_screen/bottom_sheet_details.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_list_screen.dart';
import 'package:flutter_job/ui/screens/visiting_screen/visiting_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppTypography appTypography = AppTypography();

class SightCardPlan extends StatefulWidget {
  final Place favoritePlace;
  final Function(Place) remove;
  final Function(Place) validateData;

  const SightCardPlan(
    Key? key,
    this.favoritePlace,
    this.remove,
    this.validateData,
  ) : super(key: key);

  @override
  State<SightCardPlan> createState() => _SightCardPlanState();
}

class _SightCardPlanState extends State<SightCardPlan> {
  DateTime? date;

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
                sight: widget.favoritePlace,
              );
            },
          );
        },
        splashColor: themeProvider.appTheme.whiteMainColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (_) {
            widget.remove(widget.favoritePlace);
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
                              widget.favoritePlace.urls.isNotEmpty
                                  ? widget.favoritePlace.urls[0]
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
                          onPressed: () async {
                            DateTime? selectedDate;
                            if (Platform.isAndroid) {
                              await iosPicker();
                            } else {
                              selectedDate = await androidPicker();
                              setState(() {
                                date = selectedDate;

                                placeIterator.getFavoritePlace();
                                placeIterator
                                        .dataVisited[widget.favoritePlace.id] =
                                    date;
                                widget.validateData(widget.favoritePlace);
                                dataString();
                              });
                            }
                          },
                        ),
                        CupertinoButton(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            AppAssets.close,
                            color: themeProvider.appTheme.whiteColor,
                          ),
                          onPressed: () {
                            widget.remove(widget.favoritePlace);
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Text(
                      translateTypeEng(widget.favoritePlace.placeType),
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
                        widget.favoritePlace.name,
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
                        dataString(),
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

  String dataString() {
    if (placeIterator.dataVisited.containsKey(widget.favoritePlace.id)) {
      date = placeIterator.dataVisited[widget.favoritePlace.id];

      return 'Запланировано на ${date?.day} ${date?.month} ${date?.year}';
    } else {
      return AppStrings.scheduledFor;
    }
  }

  Future<DateTime?> androidPicker() async {
    return date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: themeProvider.appTheme.greenColor, // <-- SEE HERE
              onPrimary: themeProvider.appTheme.whiteColor, // <-- SEE HERE
              onSurface: themeProvider.appTheme.mainWhiteColor,
            ),
            dialogBackgroundColor: themeProvider.appTheme.whiteMainColor,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary:
                    themeProvider.appTheme.mainWhiteColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  Future<void> iosPicker() async {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 260,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                minimumDate: DateTime(2000),
                maximumDate: DateTime(2100),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (val) {
                  setState(() {
                    date = val;
                  });
                  placeIterator.dataVisited[widget.favoritePlace.id] = date;
                },
              ),
            ),
            CupertinoButton(
              child: Text(
                AppStrings.save,
                style: TextStyle(
                  color: themeProvider.appTheme.greenColor,
                ),
              ),
              onPressed: () {
                setState(() {
                  placeIterator.getFavoritePlace();
                  widget.validateData(widget.favoritePlace);
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
