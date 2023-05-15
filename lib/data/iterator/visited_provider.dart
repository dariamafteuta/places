import 'package:flutter/cupertino.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_list_screen.dart';

class VisitedProvider with ChangeNotifier {
  List<int> visitedIdPlaces = [];
  List<Place> visitedPlaces = [];

  void getVisitedPlace() {
    visitedPlaces.clear();

    for (final id in visitedIdPlaces) {
      final place = placeRepository.getPlaceId(id);

      addVisitedPlace(place);
    }
  }

  Future<void> addVisitedPlace(Future<Place> placeFuture) async {
    final place = await placeFuture;

    visitedPlaces.add(place);
  }
}
