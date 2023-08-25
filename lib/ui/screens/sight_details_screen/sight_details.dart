import 'dart:io';
import 'package:drift/drift.dart' as dr;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/database/app_database.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';

class SightDetails extends StatefulWidget {
  final Place place;

  const SightDetails({Key? key, required this.place}) : super(key: key);

  @override
  State<SightDetails> createState() => _SightDetailsState();
}

class _SightDetailsState extends State<SightDetails> {
  late AppDatabase appDatabase;
  DateTime? date;
  bool isFavorite = false;

  Future<bool> _checkOfFavorite() async {
    final favoriteList = await appDatabase.getMyFavoriteList();
    final visitedList = await appDatabase.getMyVisitedList();

    final favorite =
        favoriteList.any((favorite) => favorite.id == widget.place.id) ||
            visitedList.any((visited) => visited.id == widget.place.id);

    if (favorite) {
      setState(() => isFavorite = favorite);
    }

    return favorite;
  }

  void _saveToFavoriteDb() {
    appDatabase.insertMyFavorite(
      FavoriteListCompanion(
        id: dr.Value(widget.place.id),
      ),
    );
  }

  void _deleteToFavoriteDb() {
    appDatabase.deleteMyFavorite(FavoriteListData(id: widget.place.id));

    _checkOfFavorite();
  }

  void _updateSelectedDate() {
    appDatabase.updateSelectedDate(
      widget.place.id,
      date,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appDatabase = Provider.of<AppDatabase>(context);
    _checkOfFavorite();
  }

  @override
  Widget build(BuildContext context) {
    final inactiveColor = themeProvider.appTheme.inactiveColor;
    final secondaryWhiteColor = themeProvider.appTheme.secondaryWhiteColor;
    final text14RegularSecondaryColor = appTypography.text14Regular.copyWith(
      color: themeProvider.appTheme.secondaryWhiteColor,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          sizedBox24H,
          _PlaceName(name: widget.place.name),
          sizedBox24H,
          _PlaceType(type: widget.place.placeType),
          sizedBox24H,
          _PlaceDetails(details: widget.place.description),
          sizedBox24H,
          _BuildRouteButton(
           place: widget.place,
          ),
          Divider(
            height: 39,
            color: inactiveColor,
            thickness: 0.8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () async {
                  DateTime? selectedDate;
                  if (Platform.isAndroid) {
                    await iosPicker();
                    setState(_updateSelectedDate);
                  } else {
                    selectedDate = await androidPicker();
                    setState(() {
                      date = selectedDate;
                      _updateSelectedDate();
                    });
                  }
                },
                icon: SvgPicture.asset(
                  isFavorite ? AppAssets.calendarFull : AppAssets.calendar,
                  color: isFavorite ? secondaryWhiteColor : inactiveColor,
                ),
                label: Text(
                  AppStrings.plan,
                  style: isFavorite
                      ? text14RegularSecondaryColor
                      : appTypography.textGreyInactive14Regular,
                ),
              ),
              sizedBox50W,
              FutureBuilder<bool>(
                future: _checkOfFavorite(),
                builder: (_, snapshot) {
                  return TextButton.icon(
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                              isFavorite
                                  ? _saveToFavoriteDb()
                                  : _deleteToFavoriteDb();
                            });
                          },
                          icon: SvgPicture.asset(
                            isFavorite ? AppAssets.heartFull : AppAssets.heart,
                            color: secondaryWhiteColor,
                          ),
                          label: Text(
                            AppStrings.toFavorites,
                            style: text14RegularSecondaryColor,
                          ),
                        );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<DateTime?> androidPicker() async {
    final mainWhiteColor = themeProvider.appTheme.mainWhiteColor;

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
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceName extends StatelessWidget {
  final String name;

  const _PlaceName({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        name,
        style: appTypography.text24Bold.copyWith(
          color: themeProvider.appTheme.mainWhiteColor,
        ),
      ),
    );
  }
}

class _PlaceType extends StatelessWidget {
  final String type;

  const _PlaceType({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        type,
        style: appTypography.text14Bold
            .copyWith(color: themeProvider.appTheme.secondarySecondary2Color),
      ),
    );
  }
}

class _PlaceDetails extends StatelessWidget {
  final String details;

  const _PlaceDetails({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        details,
        style: appTypography.text14Regular.copyWith(
          color: themeProvider.appTheme.secondaryWhiteColor,
        ),
      ),
    );
  }
}

class _BuildRouteButton extends StatelessWidget {
  final Place place;

  _BuildRouteButton({Key? key, required this.place}) : super(key: key);

  late AppDatabase appDatabase;

  @override
  Widget build(BuildContext context) {
    final whiteColor = themeProvider.appTheme.whiteColor;
    appDatabase = Provider.of<AppDatabase>(context);

    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        icon: SvgPicture.asset(
          AppAssets.go,
          color: whiteColor,
        ),
        label: Text(
          AppStrings.buildARoute,
          style: appTypography.text14Regular.copyWith(color: whiteColor),
        ),
        style: TextButton.styleFrom(
          elevation: 0.0,
          backgroundColor: themeProvider.appTheme.greenColor,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {
          final availableMaps = await MapLauncher.installedMaps;
          final selectedMap = availableMaps[0];

          await selectedMap.showMarker(
            coords: Coords(place.lat, place.lon),
            title: place.name,
            zoom: 18,
          );

         await appDatabase.insertMyVisited(
            VisitedListCompanion(
              id: dr.Value(place.id),
              selectedDate: dr.Value(DateTime.now()),
            ),
          );
          await appDatabase.deleteMyFavorite(FavoriteListData(
            id: place.id,
          ));
        },
      ),
    );
  }
}
