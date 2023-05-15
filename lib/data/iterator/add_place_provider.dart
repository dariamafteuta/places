import 'package:flutter/cupertino.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_list_screen.dart';

class AddPlaceProvider with ChangeNotifier {
  Future<void> addNewPlace(Place place) async {
    await placeRepository.postPlace(place);
  }
}
