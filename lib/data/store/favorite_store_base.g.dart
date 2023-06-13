// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_store_base.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoriteStore on FavoriteStoreBase, Store {
  late final _$likeIdPlacesAtom =
      Atom(name: 'FavoriteStoreBase.likeIdPlaces', context: context);

  @override
  ObservableList<int> get likeIdPlaces {
    _$likeIdPlacesAtom.reportRead();
    return super.likeIdPlaces;
  }

  @override
  set likeIdPlaces(ObservableList<int> value) {
    _$likeIdPlacesAtom.reportWrite(value, super.likeIdPlaces, () {
      super.likeIdPlaces = value;
    });
  }

  late final _$visitedPlacesAtom =
      Atom(name: 'FavoriteStoreBase.visitedPlaces', context: context);

  @override
  List<Place> get visitedPlaces {
    _$visitedPlacesAtom.reportRead();
    return super.visitedPlaces;
  }

  @override
  set visitedPlaces(List<Place> value) {
    _$visitedPlacesAtom.reportWrite(value, super.visitedPlaces, () {
      super.visitedPlaces = value;
    });
  }

  late final _$favoritePlacesAtom =
      Atom(name: 'FavoriteStoreBase.favoritePlaces', context: context);

  @override
  List<Place> get favoritePlaces {
    _$favoritePlacesAtom.reportRead();
    return super.favoritePlaces;
  }

  @override
  set favoritePlaces(List<Place> value) {
    _$favoritePlacesAtom.reportWrite(value, super.favoritePlaces, () {
      super.favoritePlaces = value;
    });
  }

  late final _$dataVisitedAtom =
      Atom(name: 'FavoriteStoreBase.dataVisited', context: context);

  @override
  ObservableMap<int, DateTime?> get dataVisited {
    _$dataVisitedAtom.reportRead();
    return super.dataVisited;
  }

  @override
  set dataVisited(ObservableMap<int, DateTime?> value) {
    _$dataVisitedAtom.reportWrite(value, super.dataVisited, () {
      super.dataVisited = value;
    });
  }

  late final _$getFavoritePlaceAsyncAction =
      AsyncAction('FavoriteStoreBase.getFavoritePlace', context: context);

  @override
  Future<void> getFavoritePlace() {
    return _$getFavoritePlaceAsyncAction.run(() => super.getFavoritePlace());
  }

  late final _$favoriteOrVisitedPlaceAsyncAction =
      AsyncAction('FavoriteStoreBase.favoriteOrVisitedPlace', context: context);

  @override
  Future<void> favoriteOrVisitedPlace(Future<Place> placeFuture) {
    return _$favoriteOrVisitedPlaceAsyncAction
        .run(() => super.favoriteOrVisitedPlace(placeFuture));
  }

  late final _$FavoriteStoreBaseActionController =
      ActionController(name: 'FavoriteStoreBase', context: context);

  @override
  void removePlace(Place place) {
    final _$actionInfo = _$FavoriteStoreBaseActionController.startAction(
        name: 'FavoriteStoreBase.removePlace');
    try {
      return super.removePlace(place);
    } finally {
      _$FavoriteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
likeIdPlaces: ${likeIdPlaces},
visitedPlaces: ${visitedPlaces},
favoritePlaces: ${favoritePlaces},
dataVisited: ${dataVisited}
    ''';
  }
}
