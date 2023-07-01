import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/store/places_store_base.dart';
import 'package:mobx/mobx.dart';

part 'search_place_store_base.g.dart';

class SearchPlaceStore = SearchPlaceStoreBase with _$SearchPlaceStore;

abstract class SearchPlaceStoreBase with Store {
  @action
  List<Place> searchPlaces(String name) {
    PlacesStore().getPlaces(null, null);

    final searchResult = <Place>[];

    for (final place in placeFromNet) {
      if (place.name.toLowerCase().contains(name.toLowerCase())) {
        searchResult.add(place);
      }
    }

    return searchResult
      ..sort((a, b) => PlacesStore()
          .distanceCalculate(a)
          .compareTo(PlacesStore().distanceCalculate(b)));
  }
}
