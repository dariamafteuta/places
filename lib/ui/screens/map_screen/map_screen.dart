import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job/bloc/map_bloc/map_bloc.dart';
import 'package:flutter_job/bloc/map_bloc/map_event.dart';
import 'package:flutter_job/bloc/map_bloc/map_state.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/data/store/places_store_base.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/components/bottom_navigation.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/map_screen/sight_card_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _mapController = Completer<YandexMapController>();
  final _searchController = TextEditingController();
  static final Point _point =
      Point(latitude: userLatitude, longitude: userLongitude);
  Point? newPoint;

  String searchText = '';
  Place? sight;
  bool onPlaceTap = false;

  final List<MapObject> mapObjects = [
    PlacemarkMapObject(
      mapId: const MapObjectId('icon_placemark'),
      point: _point,
      isDraggable: true,
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
        image: BitmapDescriptor.fromAssetImage(themeProvider.isLightTheme
            ? AppAssets.iAmHereWhite
            : AppAssets.iAmHereBlack),
      )),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _moveToCurrentLocation();
  }

  Future<void> _moveToCurrentLocation() async {
    await (await _mapController.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: userLatitude,
            longitude: userLongitude,
          ),
          zoom: 12,
        ),
      ),
    );
  }

  void refreshPlaces() {
    BlocProvider.of<MapBloc>(context).add(FetchPlaces());
  }

  void handlePlaceTap(Place place) {
    setState(() {
      sight = place;
      onPlaceTap = !onPlaceTap;
    });
  }

  void onMapTap(Point point) {
    setState(() {
      newPoint = point;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainWhiteColor = themeProvider.appTheme.mainWhiteColor;
    final inactiveColor = themeProvider.appTheme.inactiveColor;
    final whiteSecondaryColor = themeProvider.appTheme.whiteSecondaryColor;
    final whiteColor = themeProvider.appTheme.whiteColor;

    return MultiBlocProvider(
      providers: [
        BlocProvider<MapBloc>(
          create: (_) => MapBloc(
            Provider.of<PlacesStore>(context, listen: false),
          )..add(FetchPlaces()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 124,
          elevation: 0.0,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                AppStrings.map,
                style: appTypography.text24Bold.copyWith(
                  color: mainWhiteColor,
                ),
              ),
              sizedBox24H,
              Listener(
                onPointerDown: (_) {
                  FocusScope.of(context).unfocus();
                },
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    searchText = value;
                  },
                  cursorWidth: 1,
                  cursorColor: mainWhiteColor,
                  style: appTypography.text14Regular.copyWith(
                    color: mainWhiteColor,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: themeProvider.appTheme.backgroundColor,
                    filled: true,
                    hintText: AppStrings.search,
                    hintStyle: TextStyle(color: inactiveColor),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        AppAssets.search,
                        color: inactiveColor,
                      ),
                    ),
                    suffixIcon: _searchController.text.isEmpty
                        ? CupertinoButton(
                            onPressed: () {
                              AppNavigation.goToFilter(context);
                            },
                            padding: EdgeInsets.zero,
                            child: SvgPicture.asset(
                              AppAssets.filter,
                              color: themeProvider.appTheme.greenColor,
                            ),
                          )
                        : CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                searchText = '';
                              });
                            },
                            child: SvgPicture.asset(
                              AppAssets.clear,
                              color: mainWhiteColor,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          index: 1,
          themeProvider: themeProvider,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    backgroundColor: whiteSecondaryColor,
                    child: SvgPicture.asset(
                      AppAssets.refresh,
                      color: mainWhiteColor,
                    ),
                    onPressed: refreshPlaces,
                  ),
                  if (!onPlaceTap)
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: themeProvider.appTheme.yellowAndGreenColor,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: FloatingActionButton.extended(
                        elevation: 0,
                        backgroundColor:
                            themeProvider.appTheme.transparentColor,
                        highlightElevation: 0,
                        onPressed: () {
                          AppNavigation.goToAddSight(
                            context,
                            newPoint,
                          );
                        },
                        icon: SvgPicture.asset(
                          AppAssets.plus,
                          color: whiteColor,
                        ),
                        label: Text(
                          AppStrings.newPlace.toUpperCase(),
                          style: appTypography.text14Regular
                              .copyWith(color: whiteColor),
                        ),
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                  FloatingActionButton(
                    backgroundColor: whiteSecondaryColor,
                    child: SvgPicture.asset(
                      AppAssets.geolocation,
                      color: mainWhiteColor,
                    ),
                    onPressed: _moveToCurrentLocation,
                  ),
                ],
              ),
              if (onPlaceTap) SightCardMap(ValueKey(sight!.id), sight!),
            ],
          ),
        ),
        body: BlocBuilder<MapBloc, MapState>(
          builder: (_, state) {
            if (state is PlacesLoaded) {
              for (final place in placeFromNet) {
                final placemark = PlacemarkMapObject(
                  mapId: MapObjectId('${place.id}'),
                  point: Point(latitude: place.lat, longitude: place.lon),
                  icon: PlacemarkIcon.single(PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage(
                      themeProvider.isLightTheme
                          ? AppAssets.ellipsePlaceWhite
                          : AppAssets.ellipsePlaceBlack,
                    ),
                  )),
                  onTap: (_, point) {
                    handlePlaceTap(place);
                  },
                );

                mapObjects.add(placemark);
              }

              return YandexMap(
                onMapCreated: _mapController.complete,
                mapObjects: mapObjects,
                onMapTap: (point) {
                  final newPlacemark = PlacemarkMapObject(
                    mapId: const MapObjectId('new_icon_placemark'),
                    point: point,
                    isDraggable: true,
                    icon: PlacemarkIcon.single(PlacemarkIconStyle(
                      image: BitmapDescriptor.fromAssetImage(
                        themeProvider.isLightTheme
                            ? AppAssets.ellipseOnTapWhite
                            : AppAssets.ellipseOnTapBlack,
                      ),
                    )),
                  );

                  onMapTap(point);
                  mapObjects.add(newPlacemark);
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
