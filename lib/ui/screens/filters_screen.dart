import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/data/iterator/place_store.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/translate_type.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/content.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_list_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

AppTypography appTypography = AppTypography();
double start = 0.1;
double end = 10000;

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

  List<String> selectedType = [];
  Future<List<Place>> selectedPlaces = Future.value([]);
  int length = 0;

  @override
  Widget build(BuildContext context) {
    final placeStore = Provider.of<PlaceStore>(context, listen: false);
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
                start = 0.1;
                end = 10000;
                filter();
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
                      addType: addType,
                      removeType: removeType,
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
                  max: 10000,
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
                    filter();
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
                      '${AppStrings.show.toUpperCase()} ($length)',
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
                          builder: (context) => SightListScreen(
                            places: placeStore.getPlaces(
                              RangeValues(start, end),
                              selectedType,
                            ),
                          ),
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

  void removeType(String type) {
    setState(() {
      selectedType.remove(type);

      filter();
    });
  }

  Future<void> filter() async {
    final placeStore = Provider.of<PlaceStore>(context, listen: false);
    final selectedPlaces =
    await placeStore.getPlaces(RangeValues(start, end), selectedType);

    setState(() {
      length = selectedPlaces.length;
    });
  }

  void addType(String type) {
    setState(() {
      selectedType.add(type);

      filter();
    });
  }
}

class CategoryPlace extends StatefulWidget {
  final bool isSelected;
  final String type;
  final String image;
  final Function(String) addType;
  final Function(String) removeType;

  const CategoryPlace({
    Key? key,
    required this.type,
    required this.image,
    required this.isSelected,
    required this.addType,
    required this.removeType,
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
            widget.addType(widget.type);
          } else {
            widget.removeType(widget.type);
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
            translateTypeEng(widget.type),
            style: appTypography.text14Regular.copyWith(
              color: themeProvider.appTheme.secondaryWhiteColor,
            ),
          ),
        ],
      ),
    );
  }
}