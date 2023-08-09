// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_store_base.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlacesStore on PlacesStoreBase, Store {
  late final _$getPlacesAsyncAction =
      AsyncAction('PlacesStoreBase.getPlaces', context: context);

  @override
  Future<List<Place>> getPlaces(RangeValues? radius, List<String>? category) {
    return _$getPlacesAsyncAction.run(() => super.getPlaces(radius, category));
  }

  late final _$getPlacesFilteredAsyncAction =
      AsyncAction('PlacesStoreBase.getPlacesFiltered', context: context);

  @override
  Future<List<Place>> getPlacesFiltered(List<Place> listPlace,
      {RangeValues? radius, List<String>? category}) {
    return _$getPlacesFilteredAsyncAction.run(() =>
        super.getPlacesFiltered(listPlace, radius: radius, category: category));
  }

  late final _$PlacesStoreBaseActionController =
      ActionController(name: 'PlacesStoreBase', context: context);

  @override
  List<Place> filterListPlacesCategory(
      List<Place> placeList, List<String> category) {
    final _$actionInfo = _$PlacesStoreBaseActionController.startAction(
        name: 'PlacesStoreBase.filterListPlacesCategory');
    try {
      return super.filterListPlacesCategory(placeList, category);
    } finally {
      _$PlacesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  double distanceCalculate(Place place) {
    final _$actionInfo = _$PlacesStoreBaseActionController.startAction(
        name: 'PlacesStoreBase.distanceCalculate');
    try {
      return super.distanceCalculate(place);
    } finally {
      _$PlacesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
