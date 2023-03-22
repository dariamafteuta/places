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
    url: [
      'https://s1.bloknot-moldova.ru/thumb/610x0xcut/upload/iblock/b99/x7lfk1cquv1hh4r71m2mtp8kabiyl13n/sever.jpg',
      'https://alterainvest.ru/upload/iblock/a48/a4812115002f17495216bf21d6d8c2f1.jpg',
      'https://lh6.googleusercontent.com/QlrJRnyM62lxnFGuJ69fC7yHxXbWCPWZgjXByszWb3hYnUMknVgKCgvgXLhZXyKHyaCS6xW62A-vO7KMPL_AMhNKXUunvTdziJmojN1lgZx-LCWEqumymaaYZyUNjb67neZdfc7j',
      'https://i.simpalsmedia.com/point.md/news/600x315/a5689cfa658a6e1296c9495a19a8e6a9.jpg',
    ],
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
    url: [
      'https://mold.su/images/imagemuzei/muzei.jpg',
      'https://www.fiesta.ru/uploads/slider_image/image/32523/v880_digital-art-museum-Modern-Art-1548845-1920x1200.jpg',
      'https://n1s1.elle.ru/5d/65/8b/5d658b7b1c7d654d9e10772adaa5d29d/1880x1632_0xc35dbb80_7933678591525421728.jpg',
    ],
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
    url: [
      'https://novostipmr.com/sites/default/files/filefield_paths/silverlake002.jpg',
    ],
    details: 'Не единственное место где можно погулять и отдохнуть с семьей.',
    type: AppStrings.park,
  ),
  Sight(
    name: 'Отель Плэчинте',
    coordinate: Coordinate(
      lat: 47.506252,
      lon: 29.059111,
    ),
    url: [
      'https://idei.club/uploads/posts/2022-03/1647885944_6-idei-club-p-moldavskii-stil-v-interere-interer-krasivo-8.jpg',
      'https://cf.bstatic.com/xdata/images/hotel/max1024x768/334175291.jpg?k=bbade3c83445034d537b0344fb6df0ade7e825c93ec0f38ee5149e86a9d375dd&o=&hp=1',
    ],
    details: 'Отель 5 звезд с видом на р.Днестр',
    type: AppStrings.hotel,
  ),
  Sight(
    name: 'Дом культуры с.Бутучаны',
    coordinate: Coordinate(
      lat: 47.530868,
      lon: 29.026271,
    ),
    url: [
      'https://pmr.md/images/firm/foto/d5/d5053db8.jpg',
    ],
    details: 'Место где все занимаются творчеством.',
    type: AppStrings.particularPlace,
  ),
  Sight(
    name: 'Панарама',
    coordinate: Coordinate(
      lat: 47.523237,
      lon: 29.04112,
    ),
    url: [
      'https://media-cdn.tripadvisor.com/media/photo-s/1d/2f/11/ac/3.jpg',
    ],
    details: 'Кафе',
    type: AppStrings.cafe,
  ),
  Sight(
    name: 'Ла Плэчинте',
    coordinate: Coordinate(
      lat: 47.523804,
      lon: 29.030804,
    ),
    url: [
      'https://media-cdn.tripadvisor.com/media/photo-s/0e/20/28/b8/getlstd-property-photo.jpg',
      'https://6d6f6c646f7661.ultracdn.net/wp-content/uploads/2021/04/restaurante-traditionale.jpg',
      'https://static.locals.md/2017/04/33.jpg',
      'https://noi.md/uploads/newsthumbs/760_500/2022_07_05/625265.jpg',
      'https://static.1000.menu/img/content-v2/f8/51/5063/chernosliv-farshirovannyi-greckimi-orexami_1615141867_13_max.jpg',
    ],
    details: 'Мини ресторан',
    type: AppStrings.restaurant,
  ),
  Sight(
    name: 'Ива',
    coordinate: Coordinate(
      lat: 47.51187,
      lon: 29.095737,
    ),
    url: [
      'https://cdn.botanichka.ru/wp-content/uploads/2010/01/white-willow.jpg',
    ],
    details: 'Красивое дерево.',
    type: AppStrings.park,
  ),
];
