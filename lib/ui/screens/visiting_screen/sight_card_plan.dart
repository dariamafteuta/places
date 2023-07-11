import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/data/store/favorite_store_base.dart';
import 'package:flutter_job/ui/components/card_delete_background.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SightCardPlan extends StatefulWidget {
  final Place favoritePlace;

  const SightCardPlan(
    Key? key,
    this.favoritePlace,
  ) : super(key: key);

  @override
  State<SightCardPlan> createState() => _SightCardPlanState();
}

class _SightCardPlanState extends State<SightCardPlan> {
  DateTime? date;

  final whiteColor = themeProvider.appTheme.whiteColor;
  final mainWhiteColor = themeProvider.appTheme.mainWhiteColor;

  String _dataString() {
    final favoriteStore = Provider.of<FavoriteStore>(context, listen: false);

    if (favoriteStore.dataVisited.containsKey(widget.favoritePlace.id)) {
      date = favoriteStore.dataVisited[widget.favoritePlace.id];

      return 'Запланировано на ${date?.day} ${date?.month} ${date?.year}';
    } else {
      return AppStrings.scheduledFor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final urls = widget.favoritePlace.urls;

    final favoriteStore = Provider.of<FavoriteStore>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: InkWell(
        onTap: () {
          AppNavigation.goToSightDetails(context, widget.favoritePlace);
        },
        splashColor: themeProvider.appTheme.whiteMainColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (_) {
            favoriteStore
              ..removePlace(widget.favoritePlace)
              ..getFavoritePlace();
          },
          background: CardDeleteBackground(),
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
                      child: Hero(
                        tag: 'imageHero_${widget.favoritePlace.id}',
                        child: Ink(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                urls.isNotEmpty
                                    ? urls[0]
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
                            color: whiteColor,
                          ),
                          onPressed: () async {
                            DateTime? selectedDate;
                            if (Platform.isAndroid) {
                              await iosPicker();
                              setState(() {
                                favoriteStore
                                        .dataVisited[widget.favoritePlace.id] =
                                    date;
                                favoriteStore.getFavoritePlace();
                                _dataString();
                              });
                            } else {
                              selectedDate = await androidPicker();
                              setState(() {
                                date = selectedDate;
                                favoriteStore
                                        .dataVisited[widget.favoritePlace.id] =
                                    date;
                                favoriteStore.getFavoritePlace();
                                _dataString();
                              });
                            }
                          },
                        ),
                        CupertinoButton(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            AppAssets.close,
                            color: whiteColor,
                          ),
                          onPressed: () {
                            favoriteStore
                              ..removePlace(widget.favoritePlace)
                              ..getFavoritePlace();
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Text(
                      widget.favoritePlace.placeType,
                      style: appTypography.text14w700.copyWith(
                        color: whiteColor,
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
                        _dataString(),
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
                  primary: themeProvider.appTheme.greenColor,
                  onPrimary: themeProvider.appTheme.whiteColor,
                  onSurface: mainWhiteColor,
                ),
                dialogBackgroundColor: themeProvider.appTheme.whiteMainColor,
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: mainWhiteColor,
                  ),
                ),
              ),
              child: child!,
            );
          },
        ) ??
        DateTime.now();
  }

  Future<void> iosPicker() async {
    final favoriteStore = Provider.of<FavoriteStore>(context, listen: false);

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
                  favoriteStore.dataVisited[widget.favoritePlace.id] = date;
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
                setState(favoriteStore.getFavoritePlace);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
