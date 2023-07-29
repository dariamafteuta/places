import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job/bloc/places_bloc/places_bloc.dart';
import 'package:flutter_job/bloc/places_bloc/places_state.dart';
import 'package:flutter_job/data/store/places_store_base.dart';
import 'package:flutter_job/ui/components/animated_loader.dart';
import 'package:flutter_job/ui/components/error_sight_list_screen.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_card.dart';

class SightPortrait extends StatelessWidget {
  const SightPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (_, state) {
        if (state is PlacesLoading) {
          return const AnimatedLoader();
        } else if (state is PlacesLoaded) {
          return placeFromNet.isNotEmpty
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      final place = placeFromNet[index];

                      return SightCard(
                        ValueKey(place.id),
                        place,
                      );
                    },
                    childCount: placeFromNet.length,
                  ),
                )
              : const SizedBox.shrink();
        } else {
          return const ErrorSightListScreen();
        }
      },
    );
  }
}
