import 'package:flutter_job/data/iterator/place_store.dart';
import 'package:flutter_job/data/iterator/visited_store.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:mobx/mobx.dart';

part 'favorite_store.g.dart';

class FavoriteStore = FavoriteStoreBase with _$FavoriteStore;

abstract class FavoriteStoreBase with Store {
  final visitedStore = VisitedStore();

  @observable
  ObservableList<int> favoriteIdPlaces = ObservableList<int>();
  @observable
  ObservableList<Place> favoritePlaces = ObservableList<Place>();
  @observable
  ObservableMap<int, DateTime?> dataVisited = ObservableMap<int, DateTime?>();

  @action
  void getFavoritePlace() {
    favoritePlaces.clear();

    for (final id in favoriteIdPlaces) {
      final place = placeRepository.getPlaceId(id);

      addFavoritePlace(place);
    }
  }

  @action
  Future<void> addFavoritePlace(Future<Place> placeFuture) async {
    final place = await placeFuture;

    if (dataVisited[place.id]?.isBefore(DateTime.now()) ?? false) {
      favoriteIdPlaces.remove(place.id);
      visitedStore.visitedIdPlaces.add(place.id);

      visitedStore.getVisitedPlace();
    } else {
      favoritePlaces.add(place);
    }
  }
}