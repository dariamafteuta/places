import 'package:flutter_job/domain/coordinate.dart';
import 'package:flutter_job/domain/sight.dart';
import 'package:flutter_job/ui/res/app_strings.dart';

final List<Sight> mocks = [
  Sight(
    name: 'Кэмпинг спот',
    coordinate: Coordinate(
      lat: 47.530216,
      lon: 29.022663,
    ),
    url:
        'https://s1.bloknot-moldova.ru/thumb/610x0xcut/upload/iblock/b99/x7lfk1cquv1hh4r71m2mtp8kabiyl13n/sever.jpg',
    details:
        'Когда взбираешься на вершину холма открывается прекрасный вид на реку Днестр.',
    type: AppStrings.park,
  ),
  Sight(
    name: 'Художественный музей',
    coordinate: Coordinate(
      lat: 47.525589,
      lon: 29.03041,
    ),
    url: 'https://mold.su/images/imagemuzei/muzei.jpg',
    details:
        'В музее постоянно проводятся выставки европейского, русского и восточного искусства. ',
    type: AppStrings.museum,
  ),
  Sight(
    name: 'Парк Жура',
    coordinate: Coordinate(
      lat: 47.524175,
      lon: 29.064811,
    ),
    url:
        'https://novostipmr.com/sites/default/files/filefield_paths/silverlake002.jpg',
    details: 'Не единственное место где можно погулять и отдохнуть с семьей.',
    type: AppStrings.park,
  ),
  Sight(
    name: 'Отель Плэчинте',
    coordinate: Coordinate(
      lat: 47.506252,
      lon: 29.059111,
    ),
    url:
        'https://idei.club/uploads/posts/2022-03/1647885944_6-idei-club-p-moldavskii-stil-v-interere-interer-krasivo-8.jpg',
    details: 'Отель 5 звезд с видом на р.Днестр',
    type: AppStrings.hotel,
  ),
  Sight(
    name: 'Дом культуры с.Бутучаны',
    coordinate: Coordinate(
      lat: 47.530868,
      lon: 29.026271,
    ),
    url: 'https://pmr.md/images/firm/foto/d5/d5053db8.jpg',
    details: 'Место где все занимаются творчеством.',
    type: AppStrings.particularPlace,
  ),
  Sight(
    name: 'Панарама',
    coordinate: Coordinate(
      lat: 47.523237,
      lon: 29.04112,
    ),
    url: 'https://media-cdn.tripadvisor.com/media/photo-s/1d/2f/11/ac/3.jpg',
    details: 'Кафе',
    type: AppStrings.cafe,
  ),
  Sight(
    name: 'Ла Плэчинте',
    coordinate: Coordinate(
      lat: 47.523804,
      lon: 29.030804,
    ),
    url:
        'https://media-cdn.tripadvisor.com/media/photo-s/0e/20/28/b8/getlstd-property-photo.jpg',
    details: 'Мини ресторан',
    type: AppStrings.restaurant,
  ),
  Sight(
    name: 'Ива',
    coordinate: Coordinate(
      lat: 47.51187,
      lon: 29.095737,
    ),
    url:
        'https://cdn.botanichka.ru/wp-content/uploads/2010/01/white-willow.jpg',
    details: 'Красивое дерево.',
    type: AppStrings.park,
  ),
];
