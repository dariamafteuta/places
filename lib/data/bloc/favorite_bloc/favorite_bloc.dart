import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job/data/bloc/favorite_bloc/favorite_event.dart';
import 'package:flutter_job/data/bloc/favorite_bloc/favorite_state.dart';
import 'package:flutter_job/store/favorite_store_base.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteStore favoriteStore;

  FavoriteBloc(this.favoriteStore) : super(FavoritePlaceLoading()) {
    on<FetchFavorite>((event, emit) async {
      emit(FavoritePlaceLoading());

      await favoriteStore.getFavoritePlace();

      emit(FavoritePlaceLoaded());
    });
  }
}
