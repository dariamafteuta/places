import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job/bloc/search_bloc/search_event.dart';
import 'package:flutter_job/bloc/search_bloc/search_state.dart';
import 'package:flutter_job/data/store/search_place_store_base.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchPlaceStore searchPlaceStore;

  SearchBloc(this.searchPlaceStore) : super(SearchInitialState()) {
    on<PerformSearch>((event, emit) async {
      final searchResults = searchPlaceStore.searchPlaces(event.searchText);

      emit(SearchResultsState(searchResults));
    });
  }
}
