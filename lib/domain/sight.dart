import 'package:flutter_job/domain/coordinate.dart';
import 'package:flutter_job/ui/screen/filters_screen.dart';

class Sight {
  final String name;
  final Coordinate coordinate;
  final String url;
  final String details;
  final String type;

  Sight({
    required this.name,
    required this.coordinate,
    required this.url,
    required this.details,
    required this.type,
  });
}
