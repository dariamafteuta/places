import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_list_screen.dart';
import 'package:mobx/mobx.dart';

part 'add_place_store.g.dart';

class AddPlaceStore = AddPlaceStoreBase with _$AddPlaceStore;

abstract class AddPlaceStoreBase with Store {
  @action
  Future<void> addNewPlace(Place place) async {
    await placeRepository.postPlace(place);
  }
}
