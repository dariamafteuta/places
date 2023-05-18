// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visited_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VisitedStore on VisitedStoreBase, Store {
  late final _$visitedIdPlacesAtom =
      Atom(name: 'VisitedStoreBase.visitedIdPlaces', context: context);

  @override
  List<int> get visitedIdPlaces {
    _$visitedIdPlacesAtom.reportRead();
    return super.visitedIdPlaces;
  }

  @override
  set visitedIdPlaces(List<int> value) {
    _$visitedIdPlacesAtom.reportWrite(value, super.visitedIdPlaces, () {
      super.visitedIdPlaces = value;
    });
  }

  late final _$visitedPlacesAtom =
      Atom(name: 'VisitedStoreBase.visitedPlaces', context: context);

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

  late final _$addVisitedPlaceAsyncAction =
      AsyncAction('VisitedStoreBase.addVisitedPlace', context: context);

  @override
  Future<void> addVisitedPlace(Future<Place> placeFuture) {
    return _$addVisitedPlaceAsyncAction
        .run(() => super.addVisitedPlace(placeFuture));
  }

  late final _$VisitedStoreBaseActionController =
      ActionController(name: 'VisitedStoreBase', context: context);

  @override
  void getVisitedPlace() {
    final _$actionInfo = _$VisitedStoreBaseActionController.startAction(
        name: 'VisitedStoreBase.getVisitedPlace');
    try {
      return super.getVisitedPlace();
    } finally {
      _$VisitedStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
visitedIdPlaces: ${visitedIdPlaces},
visitedPlaces: ${visitedPlaces}
    ''';
  }
}
