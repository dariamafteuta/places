import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job/data/bloc/visited_bloc/visited_event.dart';
import 'package:flutter_job/data/bloc/visited_bloc/visited_state.dart';
import 'package:flutter_job/data/store/favorite_store_base.dart';

class VisitedBloc extends Bloc<VisitedEvent, VisitedState> {
  final FavoriteStore favoriteStore;

  VisitedBloc(this.favoriteStore) : super(VisitedPlaceLoading()) {
    on<FetchVisited>((event, emit) async {
      emit(VisitedPlaceLoading());

      await favoriteStore.getFavoritePlace();

      emit(VisitedPlaceLoaded());
    });
  }
}