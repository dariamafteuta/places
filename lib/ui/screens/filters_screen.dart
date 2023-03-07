import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/domain/coordinate.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/mocks.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/screens/content.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

AppTypography appTypography = AppTypography();
double start = 0.1;
double end = 10;

class _FiltersScreenState extends State<FiltersScreen> {
  Iterable<String> listOfPlaces = mocks.map((e) => e.type);
  Set<String> selectedType = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: CupertinoButton(
          child: SvgPicture.asset(
            AppAssets.arrow,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          CupertinoButton(
            child: Text(
              AppStrings.clear,
              style: appTypography.textGreen18Bold.copyWith(
                color: themeProvider.appTheme.greenColor,
              ),
            ),
            onPressed: () {
              setState(() {
                selectedType.clear();
                listOfPlaces = mocks.map((e) => e.type);
                start = 0.1;
                end = 10;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 16,
        ),
        child: Column(
          children: [
           const Content(content: AppStrings.categories),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CategoryPlace(
                      isSelected: selectedType.contains(AppStrings.cafe),
                      image: AppAssets.cafeWhite,
                      type: AppStrings.cafe,
                      setSelectedType: setSelectedType,
                      removePlace: removePlace,
                    ),
                    CategoryPlace(
                      isSelected: selectedType.contains(AppStrings.hotel),
                      image: AppAssets.hotelWhite,
                      type: AppStrings.hotel,
                      setSelectedType: setSelectedType,
                      removePlace: removePlace,
                    ),
                  ],
                ),
                Column(
                  children: [
                    CategoryPlace(
                      isSelected: selectedType.contains(AppStrings.park),
                      image: AppAssets.parkWhite,
                      type: AppStrings.park,
                      setSelectedType: setSelectedType,
                      removePlace: removePlace,
                    ),
                    CategoryPlace(
                      isSelected: selectedType.contains(AppStrings.restaurant),
                      image: AppAssets.restaurantWhite,
                      type: AppStrings.restaurant,
                      setSelectedType: setSelectedType,
                      removePlace: removePlace,
                    ),
                  ],
                ),
                Column(
                  children: [
                    CategoryPlace(
                      isSelected:
                          selectedType.contains(AppStrings.particularPlace),
                      image: AppAssets.particularPlaceWhite,
                      type: AppStrings.particularPlace,
                      setSelectedType: setSelectedType,
                      removePlace: removePlace,
                    ),
                    CategoryPlace(
                      isSelected: selectedType.contains(AppStrings.museum),
                      image: AppAssets.museumWhite,
                      type: AppStrings.museum,
                      setSelectedType: setSelectedType,
                      removePlace: removePlace,
                    ),
                  ],
                ),
              ],
            ),
            sizedBox60H,
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.distance,
                      style: appTypography.text14Regular.copyWith(
                        fontSize: 16,
                        color: themeProvider.appTheme.secondaryWhiteColor,
                      ),
                    ),
                    Text(
                      'от ${start.toStringAsFixed(1)} до ${end.toStringAsFixed(1)} км',
                      style: appTypography.textGreyInactive14Regular.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                sizedBox32H,
                RangeSlider(
                  min: 0.1,
                  max: 10,
                  values: RangeValues(
                    start,
                    end,
                  ),
                  labels: RangeLabels(
                    start.toStringAsFixed(1),
                    end.toStringAsFixed(1),
                  ),
                  onChanged: (values) {
                    setState(() {
                      start = values.start;
                      end = values.end;
                    });
                    handleChangeRadius();
                  },
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: TextButton(
                    child: Text(
                      '${AppStrings.show} (${listOfPlaces.length})',
                      style: appTypography.text14Regular
                          .copyWith(color: themeProvider.appTheme.whiteColor),
                    ),
                    style: TextButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: themeProvider.appTheme.greenColor,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void removePlace(String type) {
    selectedType.remove(type);

    handleChangeRadius();
  }

  void addPlaces() {
    final selectedPlaces = <String>[];

    for (var i = 0; i < mocks.length; i++) {
      if (selectedType.contains(mocks[i].type) &&
          radius(mocks[i].coordinate, start, end)) {
        selectedPlaces.add(mocks[i].name);
      } else {
        selectedPlaces.remove(mocks[i].name);
      }
    }

    setListOfPlaces(selectedPlaces);
  }

  void handleChangeRadius() {
    addPlaces();
  }

  void setListOfPlaces(List<String> newList) {
    setState(() {
      listOfPlaces = newList;
    });
  }

  void setSelectedType(String type) {
    selectedType.add(type);

    handleChangeRadius();
  }
}

bool radius(Coordinate checkPoint, double start, double end) {
  final centerPoint = Coordinate(
    lat: 47.52882,
    lon: 29.0336,
  );
  const ky = 40000 / 360;
  final kx = cos(pi * centerPoint.lat / 180.0) * ky;
  final dx = (centerPoint.lon - checkPoint.lon).abs() * kx;
  final dy = (centerPoint.lat - checkPoint.lat).abs() * ky;

  final calculatedDistance = sqrt(dx * dx + dy * dy);

  return calculatedDistance >= start && calculatedDistance <= end;
}

class CategoryPlace extends StatefulWidget {
  final bool isSelected;
  final String type;
  final String image;
  final Function(String) setSelectedType;
  final Function(String) removePlace;

  const CategoryPlace({
    Key? key,
    required this.type,
    required this.image,
    required this.setSelectedType,
    required this.removePlace,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<CategoryPlace> createState() => _CategoryPlaceState();
}

class _CategoryPlaceState extends State<CategoryPlace> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoButton(
          child: !widget.isSelected
              ? SvgPicture.asset(widget.image)
              : SizedBox(
                  height: 64,
                  width: 64,
                  child: Stack(
                    children: [
                      SvgPicture.asset(widget.image),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SvgPicture.asset(
                          AppAssets.tickChoice,
                        ),
                      ),
                    ],
                  ),
                ),
          onPressed: () {
            setState(() {
              final isSelected = !widget.isSelected;
              if (isSelected) {
                widget.setSelectedType(widget.type);
              } else {
                widget.removePlace(widget.type);
              }
            });
          },
        ),
        Text(
          widget.type,
          style: appTypography.text14Regular.copyWith(
            color: themeProvider.appTheme.secondaryWhiteColor,
          ),
        ),
      ],
    );
  }
}
