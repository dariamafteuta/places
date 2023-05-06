import 'package:flutter_job/ui/res/app_strings.dart';

String translateTypeRu(String type) {
  switch (type) {
    case AppStrings.cafe:
      return 'cafe';
    case AppStrings.park:
      return 'park';
    case AppStrings.museum:
      return 'museum';
    case AppStrings.hotel:
      return 'hotel';
    case AppStrings.restaurant:
      return 'restaurant';
    default:
      return 'particular place';
  }
}

String translateTypeEng(dynamic type) {
  switch (type) {
    case 'cafe':
      return AppStrings.cafe;
    case 'park':
      return AppStrings.park;
    case 'museum':
      return AppStrings.museum;
    case 'hotel':
      return AppStrings.hotel;
    case 'restaurant':
      return AppStrings.restaurant;
    default:
      return AppStrings.particularPlace;
  }
}
