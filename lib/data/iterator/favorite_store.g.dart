// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoriteStore on FavoriteStoreBase, Store {
  late final _$favoriteIdPlacesAtom =
      Atom(name: 'FavoriteStoreBase.favoriteIdPlaces', context: context);

  @override
  ObservableList<int> get favoriteIdPlaces {
    _$favoriteIdPlacesAtom.reportRead();
    return super.favoriteIdPlaces;
  }

  @override
  set favoriteIdPlaces(ObservableList<int> value) {
    _$favoriteIdPlacesAtom.reportWrite(value, super.favoriteIdPlaces, () {
      super.favoriteIdPlaces = value;
    });
  }

  late final _$favoritePlacesAtom =
      Atom(name: 'FavoriteStoreBase.favoritePlaces', context: context);

  @override
  ObservableList<Place> get favoritePlaces {
    _$favoritePlacesAtom.reportRead();
    return super.favoritePlaces;
  }

  @override
  set favoritePlaces(ObservableList<Place> value) {
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

  late final _$addFavoritePlaceAsyncAction =
      AsyncAction('FavoriteStoreBase.addFavoritePlace', context: context);

  @override
  Future<void> addFavoritePlace(Future<Place> placeFuture) {
    return _$addFavoritePlaceAsyncAction
        .run(() => super.addFavoritePlace(placeFuture));
  }

  late final _$FavoriteStoreBaseActionController =
      ActionController(name: 'FavoriteStoreBase', context: context);

  @override
  void getFavoritePlace() {
    final _$actionInfo = _$FavoriteStoreBaseActionController.startAction(
        name: 'FavoriteStoreBase.getFavoritePlace');
    try {
      return super.getFavoritePlace();
    } finally {
      _$FavoriteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favoriteIdPlaces: ${favoriteIdPlaces},
favoritePlaces: ${favoritePlaces},
dataVisited: ${dataVisited}
    ''';
  }
}
