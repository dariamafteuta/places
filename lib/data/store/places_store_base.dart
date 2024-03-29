import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_job/app.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/repository/place_repository.dart';
import 'package:flutter_job/domain/coordinate.dart';
import 'package:mobx/mobx.dart';

part 'places_store_base.g.dart';

class PlacesStore = PlacesStoreBase with _$PlacesStore;

List<Place> placeFromNet = [];

abstract class PlacesStoreBase with Store {
  @action
  Future<List<Place>> getPlaces(
    RangeValues? radius,
    List<String>? category,
  ) async {
    placeFromNet = await PlaceRepository().getPlace();

    placeFromNet = await getPlacesFiltered(
      placeFromNet,
      radius: radius,
      category: category,
    );

    return placeFromNet
      ..sort((a, b) => distanceCalculate(a).compareTo(distanceCalculate(b)));
  }

  @action
  Future<List<Place>> getPlacesFiltered(
    List<Place> listPlace, {
    RangeValues? radius,
    List<String>? category,
  }) async {
    List<Place> listPlaceFiltered;

    listPlaceFiltered = listPlace.isEmpty ? placeFromNet : listPlace;

    if (radius != null) {
      listPlaceFiltered = filterListPlacesRadius(listPlace, radius);
    }

    if (category != null) {
      listPlaceFiltered = filterListPlacesCategory(listPlaceFiltered, category);
    }

    placeFromNet = listPlaceFiltered;

    return listPlaceFiltered;
  }

  List<Place> filterListPlacesRadius(
    List<Place> placeList,
    RangeValues radius,
  ) {
    final listPlaceFiltered =
        placeList.where((element) => filterRadius(element, radius)).toList();

    return listPlaceFiltered;
  }

  bool filterRadius(Place place, RangeValues rangeValues) {
    final centerPoint = Coordinate(
      lat: userLatitude,
      lon: userLongitude,
    );
    const ky = 40000 / 360;
    final kx = cos(pi * centerPoint.lat / 180.0) * ky;
    final dx = (centerPoint.lon - place.lon).abs() * kx;
    final dy = (centerPoint.lat - place.lat).abs() * ky;

    final calculatedDistance = sqrt(dx * dx + dy * dy);

    return calculatedDistance >= rangeValues.start &&
        calculatedDistance <= rangeValues.end;
  }

  @action
  List<Place> filterListPlacesCategory(
    List<Place> placeList,
    List<String> category,
  ) {
    final listPlaceFiltered =
        placeList.where((place) => category.contains(place.placeType)).toList();

    return listPlaceFiltered;
  }

  @action
  double distanceCalculate(Place place) {
    final centerPoint = Coordinate(
      lat: userLatitude,
      lon: userLongitude,
    );
    const ky = 40000 / 360;
    final kx = cos(pi * centerPoint.lat / 180.0) * ky;
    final dx = (centerPoint.lon - place.lon).abs() * kx;
    final dy = (centerPoint.lat - place.lat).abs() * ky;

    final calculatedDistance = sqrt(dx * dx + dy * dy);

    return calculatedDistance;
  }
}
