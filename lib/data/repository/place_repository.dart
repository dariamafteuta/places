import 'dart:convert';

import 'package:flutter_job/data/api_urls.dart';
import 'package:flutter_job/data/connection_server.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/ui/res/translate_type.dart';
import 'package:http/http.dart' as http;

class PlaceRepository {
  final ConnectionServer server = ConnectionServer();

  Future<void> postPlace(Place place) async {
    final url = Uri.parse(urlParse);
    final headers = {'Content-Type': 'application/json'};

    final data = jsonEncode({
      'lat': place.lat,
      'lng': place.lon,
      'name': place.name,
      'urls': place.urls,
      'placeType': translateTypeRu(place.placeType),
      'description': place.description,
    });

    await http.post(url, headers: headers, body: data);
  }

  Future<List<Place>> getPlace() async {
    return ((await server.get(urlPlace)).data as List)
        .map((dynamic e) => Place.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Place> getPlaceId(int id) async {
    final response = await server.get('$urlPlace/$id');
    if (response.statusCode == 200) {
      final dynamic placeJson = response.data;

      final place = Place.fromJson(placeJson as Map<String, dynamic>);

      return place;
    }
    throw Exception('No 200 status code: Error code: ${response.statusCode}');
  }
}
