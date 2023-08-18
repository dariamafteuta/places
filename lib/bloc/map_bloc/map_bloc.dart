import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job/data/store/places_store_base.dart';
import 'package:flutter_job/bloc/map_bloc/map_event.dart';
import 'package:flutter_job/bloc/map_bloc/map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final PlacesStore placesStore;

  MapBloc(this.placesStore,) : super(PlacesLoading()) {
    on<FetchPlaces>((event, emit) async {
      emit(PlacesLoading());

      await placesStore.getPlaces(null, null);

      emit(PlacesLoaded());
    });
  }
}