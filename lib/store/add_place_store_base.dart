import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/repository/place_repository.dart';
import 'package:mobx/mobx.dart';

part 'add_place_store_base.g.dart';

class AddPlaceStore = AddPlaceStoreBase with _$AddPlaceStore;

abstract class AddPlaceStoreBase with Store {
  @action
  Future<void> addNewPlace(Place place) async {
    await PlaceRepository().postPlace(place);
  }
}
