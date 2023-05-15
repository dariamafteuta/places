import 'package:flutter/cupertino.dart';
import 'package:flutter_job/data/iterator/place_provider.dart';
import 'package:flutter_job/data/iterator/visited_provider.dart';
import 'package:flutter_job/data/model/place.dart';

class FavoriteProvider with ChangeNotifier {
  List<int> favoriteIdPlaces = [];
  List<Place> favoritePlaces = [];
  Map<int, DateTime?> dataVisited = {};

  void getFavoritePlace() {
    favoritePlaces.clear();

    for (final id in favoriteIdPlaces) {
      final place = placeRepository.getPlaceId(id);

      addFavoritePlace(place);
    }
  }

  Future<void> addFavoritePlace(Future<Place> placeFuture) async {
    final place = await placeFuture;

    if (dataVisited[place.id]?.isBefore(DateTime.now()) ?? false) {
      favoriteIdPlaces.remove(place.id);
      VisitedProvider().visitedIdPlaces.add(place.id);

      VisitedProvider().getVisitedPlace();
    } else {
      favoritePlaces.add(place);
    }
  }
}
