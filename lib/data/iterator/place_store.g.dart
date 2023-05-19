// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlaceStore on PlaceStoreBase, Store {
  late final _$placeFromNetAtom =
      Atom(name: 'PlaceStoreBase.placeFromNet', context: context);

  @override
  List<Place> get placeFromNet {
    _$placeFromNetAtom.reportRead();
    return super.placeFromNet;
  }

  @override
  set placeFromNet(List<Place> value) {
    _$placeFromNetAtom.reportWrite(value, super.placeFromNet, () {
      super.placeFromNet = value;
    });
  }

  late final _$getPlacesAsyncAction =
      AsyncAction('PlaceStoreBase.getPlaces', context: context);

  @override
  Future<List<Place>> getPlaces(RangeValues? radius, List<String>? category) {
    return _$getPlacesAsyncAction.run(() => super.getPlaces(radius, category));
  }

  late final _$getPlacesFilteredAsyncAction =
      AsyncAction('PlaceStoreBase.getPlacesFiltered', context: context);

  @override
  Future<List<Place>> getPlacesFiltered(List<Place> listPlace,
      {RangeValues? radius, List<String>? category}) {
    return _$getPlacesFilteredAsyncAction.run(() =>
        super.getPlacesFiltered(listPlace, radius: radius, category: category));
  }

  late final _$PlaceStoreBaseActionController =
      ActionController(name: 'PlaceStoreBase', context: context);

  @override
  List<Place> filterListPlacesCategory(
      List<Place> placeList, List<String> category) {
    final _$actionInfo = _$PlaceStoreBaseActionController.startAction(
        name: 'PlaceStoreBase.filterListPlacesCategory');
    try {
      return super.filterListPlacesCategory(placeList, category);
    } finally {
      _$PlaceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  double distanceCalculate(Place place) {
    final _$actionInfo = _$PlaceStoreBaseActionController.startAction(
        name: 'PlaceStoreBase.distanceCalculate');
    try {
      return super.distanceCalculate(place);
    } finally {
      _$PlaceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<Place> searchPlaces(String name) {
    final _$actionInfo = _$PlaceStoreBaseActionController.startAction(
        name: 'PlaceStoreBase.searchPlaces');
    try {
      return super.searchPlaces(name);
    } finally {
      _$PlaceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
placeFromNet: ${placeFromNet}
    ''';
  }
}
