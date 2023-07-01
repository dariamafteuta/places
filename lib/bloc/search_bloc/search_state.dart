import 'package:flutter_job/data/model/place.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchResultsState extends SearchState {
  final List<Place> searchResults;

  SearchResultsState(this.searchResults);
}

class SearchErrorState extends SearchState {}
