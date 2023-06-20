import 'package:flutter/cupertino.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/store/add_place_store_base.dart';
import 'package:flutter_job/ui/screens/new_place_screen/add_sight_screen.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

import 'package:flutter_job/data/store/place_store_base.dart';

class AddPlaceWidgetModel extends WidgetModel {
  AddPlaceWidgetModel(WidgetModelDependencies dependencies) : super(dependencies);

  final StreamedState<String> nameState = StreamedState('');
  final StreamedState<String> categoryState = StreamedState('');
  final StreamedState<String> latitudeState = StreamedState('');
  final StreamedState<String> longitudeState = StreamedState('');
  final StreamedState<String> descriptionState = StreamedState('');

  void submitForm() {
      final place = Place(
        id: placeFromNet.length + 1,
        lat: double.parse(latitudeState.value),
        lon: double.parse(longitudeState.value),
        name: nameState.value,
        urls: list,
        placeType: categoryState.value,
        description: descriptionState.value,
      );

      try {
        AddPlaceStore().addNewPlace(place);
        debugPrint('${place.name}, ${place.placeType}, ${place.urls}');
      } catch (e) {
        debugPrint('Error: $e');
      }
  }

  String? validateName(String value) {
    return value.isEmpty ? 'Введите название' : null;
  }

  String? validateDescription(String value) {
    return value.isEmpty ? 'Введите описание' : null;
  }

  String? validateLatitude(String value) {
    if (value.isEmpty) {
      return 'Введите координаты';
    } else if (double.parse(value) > 90) {
      return 'Неправельные координаты';
    } else {
      return null;
    }
  }

  String? validateLongitude(String value) {
    if (value.isEmpty) {
      return 'Введите координаты';
    } else if (double.parse(value) > 180) {
      return 'Неправельные координаты';
    } else {
      return null;
    }
  }

  String? validateCategory(String value) {
    return value.isEmpty ? 'Выберите категорию' : null;
  }
}