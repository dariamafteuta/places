import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_list_screen.dart';
import 'package:mobx/mobx.dart';

part 'visited_store.g.dart';

class VisitedStore = VisitedStoreBase with _$VisitedStore;

abstract class VisitedStoreBase with Store {
  @observable
  List<int> visitedIdPlaces = [];
  @observable
  List<Place> visitedPlaces = [];

  @action
  void getVisitedPlace() {
    visitedPlaces.clear();

    for (final id in visitedIdPlaces) {
      final place = placeRepository.getPlaceId(id);

      addVisitedPlace(place);
    }
  }

  @action
  Future<void> addVisitedPlace(Future<Place> placeFuture) async {
    final place = await placeFuture;

    visitedPlaces.add(place);
  }
}
