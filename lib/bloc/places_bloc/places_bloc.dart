import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job/bloc/places_bloc/places_event.dart';
import 'package:flutter_job/bloc/places_bloc/places_state.dart';
import 'package:flutter_job/data/store/places_store_base.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final PlacesStore placesStore;
  final RangeValues? radius;
  final List<String>? type;

  PlacesBloc(this.placesStore, {required this.radius, required this.type}) : super(PlacesLoading()) {
    on<FetchPlaces>((event, emit) async {
      emit(PlacesLoading());

      await placesStore.getPlaces(radius, type);

      emit(PlacesLoaded());
    });
  }
}