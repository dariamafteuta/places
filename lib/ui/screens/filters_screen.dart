import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/domain/coordinate.dart';
import 'package:flutter_job/domain/sight.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/mocks.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/content.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_list_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppTypography appTypography = AppTypography();
double start = 0.1;
double end = 10;

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  List<String> listType = [
    AppStrings.hotel,
    AppStrings.restaurant,
    AppStrings.particularPlace,
    AppStrings.park,
    AppStrings.museum,
    AppStrings.cafe,
  ];
  List<String> listImages = [
    AppAssets.hotelWhite,
    AppAssets.restaurantWhite,
    AppAssets.particularPlaceWhite,
    AppAssets.parkWhite,
    AppAssets.museumWhite,
    AppAssets.cafeWhite,
  ];

  Iterable<Sight> listOfPlaces = mocks.map((e) => e);
  Set<String> selectedType = {};

  @override
  Widget build(BuildContext context) {
    final largeScreenSize = MediaQuery.of(context).size.width > 320;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: CupertinoButton(
          child: SvgPicture.asset(
            AppAssets.arrow,
            color: themeProvider.appTheme.mainWhiteColor,
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
                listOfPlaces = mocks.map((e) => e);
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
        child: ListView(
          children: [
            const Content(content: AppStrings.categories),
            SizedBox(
              height: largeScreenSize ? null : 140,
              child: GridView.count(
                crossAxisCount: largeScreenSize ? 3 : 1,
                shrinkWrap: true,
                scrollDirection:
                    largeScreenSize ? Axis.vertical : Axis.horizontal,
                children: List.generate(listType.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: CategoryPlace(
                      isSelected: selectedType.contains(listType[index]),
                      image: listImages[index],
                      type: listType[index],
                      setSelectedType: setSelectedType,
                      removePlace: removePlace,
                    ),
                  );
                }),
              ),
            ),
            if (largeScreenSize) sizedBox60H else sizedBox2H,
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
            sizedBox24H,
            SizedBox(
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
                onPressed: () {
                  Navigator.push<FiltersScreen>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SightListScreen(listOfPlaces),
                    ),
                  );
                },
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
    final selectedPlaces = <Sight>[];

    for (var i = 0; i < mocks.length; i++) {
      if (selectedType.contains(mocks[i].type) &&
          radius(mocks[i].coordinate, start, end)) {
        selectedPlaces.add(mocks[i]);
      } else {
        selectedPlaces.remove(mocks[i]);
      }
    }

    setListOfPlaces(selectedPlaces);
  }

  void handleChangeRadius() {
    addPlaces();
  }

  void setListOfPlaces(List<Sight> newList) {
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
    return InkWell(
      highlightColor: themeProvider.appTheme.transparentColor,
      splashColor: themeProvider.appTheme.transparentColor,
      onTap: () {
        setState(() {
          final isSelected = !widget.isSelected;
          if (isSelected) {
            widget.setSelectedType(widget.type);
          } else {
            widget.removePlace(widget.type);
          }
        });
      },
      child: Column(
        children: [
          if (!widget.isSelected)
            SvgPicture.asset(widget.image)
          else
            SizedBox(
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
          sizedBox12H,
          Text(
            widget.type,
            style: appTypography.text14Regular.copyWith(
              color: themeProvider.appTheme.secondaryWhiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
