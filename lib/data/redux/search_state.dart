import 'package:flutter_job/data/model/place.dart';

class SearchState {
  final List<Place> searchResult;

  const SearchState({
    required this.searchResult,
  });

  factory SearchState.initialState() {
    return const SearchState(
      searchResult: [],
    );
  }

  SearchState copyWith({
    List<Place>? searchResult,
  }) {
    return SearchState(
      searchResult: searchResult ?? this.searchResult,
    );
  }
}
