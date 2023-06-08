import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/repository/place_repository.dart';
import 'package:mobx/mobx.dart';

part 'favorite_store_base.g.dart';

class FavoriteStore = FavoriteStoreBase with _$FavoriteStore;

abstract class FavoriteStoreBase with Store {
  @observable
  ObservableList<int> likeIdPlaces = ObservableList<int>();
  @observable
  List<Place> visitedPlaces = [];
  @observable
  List<Place> favoritePlaces = [];
  @observable
  ObservableMap<int, DateTime?> dataVisited = ObservableMap<int, DateTime?>();

  @action
  Future<void> getFavoritePlace() async {
    favoritePlaces.clear();
    visitedPlaces.clear();

    for (final id in likeIdPlaces) {
      final place = PlaceRepository().getPlaceId(id);

      await favoriteOrVisitedPlace(place);
    }
  }

  @action
  Future<void> favoriteOrVisitedPlace(Future<Place> placeFuture) async {
    final place = await placeFuture;

    if (dataVisited[place.id]?.isBefore(DateTime.now()) ?? false) {
      visitedPlaces.add(place);
    } else {
      favoritePlaces.add(place);
    }
  }

  @action
  void removePlace(Place place) {
    likeIdPlaces.remove(place.id);
    dataVisited.remove(place.id);
  }
}
