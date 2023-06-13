import 'package:flutter_job/data/redux/search_action.dart';
import 'package:flutter_job/data/redux/search_state.dart';
import 'package:redux/redux.dart';

SearchState searchReducer(SearchState state, dynamic action) {
  if (action is SetSearchResultAction) {
    return state.copyWith(searchResult: action.searchResult);
  }

  return state;
}

final Reducer<SearchState> rootReducer = combineReducers<SearchState>([
  TypedReducer<SearchState, SetSearchResultAction>(searchReducer),
]);
