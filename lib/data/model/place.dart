import 'package:flutter_job/ui/res/translate_type.dart';

class Place {
  final int id;
  final double lat;
  final double lon;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  Place({
    required this.id,
    required this.lat,
    required this.lon,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json['id'] as int? ?? 0,
        lat: json['lat'] as double? ?? 0.0,
        lon: json['lng'] as double? ?? 0.0,
        name: json['name'] as String? ?? 'name',
        urls: json['urls'] == null
            ? []
            : (json['urls'] as List<dynamic>)
                .map((dynamic e) => e as String)
                .toList(),
        placeType: translateTypeEng(json['placeType']),
        description: json['description'] as String? ?? 'description',
      );
}
