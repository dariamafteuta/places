import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job/data/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:flutter_job/data/bloc/favorite_bloc/favorite_event.dart';
import 'package:flutter_job/data/bloc/favorite_bloc/favorite_state.dart';
import 'package:flutter_job/data/bloc/visited_bloc/visited_bloc.dart';
import 'package:flutter_job/data/bloc/visited_bloc/visited_event.dart';
import 'package:flutter_job/data/bloc/visited_bloc/visited_state.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/store/favorite_store_base.dart';
import 'package:flutter_job/ui/components/bottom_navigation.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/visiting_screen/sight_card_plan.dart';
import 'package:flutter_job/ui/screens/visiting_screen/sight_card_visited.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteStore favoriteStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    favoriteStore = Provider.of<FavoriteStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteBloc>(
      create: (_) => FavoriteBloc(favoriteStore)..add(FetchFavorite()),
      child: BlocProvider<VisitedBloc>(
        create: (_) => VisitedBloc(favoriteStore)..add(FetchVisited()),
        child: Builder(builder: (_) => _buildPage()),
      ),
    );
  }

  Widget _buildPage() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(),
        bottomNavigationBar: const BottomNavigation(
          index: 2,
        ),
        body: TabBarView(
          children: [
            BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (_, state) {
                if (state is FavoritePlaceLoaded) {
                  if (favoriteStore.favoritePlaces.isNotEmpty) {
                    return _buildFavoritePlacesListView();
                  } else if (favoriteStore.favoritePlaces.isEmpty) {
                    return _buildEmptyFavoritePlaces();
                  }
                }
                return Center(child: CircularProgressIndicator(color: themeProvider.appTheme.inactiveColor,));
              },
            ),
            BlocBuilder<VisitedBloc, VisitedState>(
              builder: (_, state) {
                if (state is VisitedPlaceLoaded) {
                  if (favoriteStore.visitedPlaces.isNotEmpty) {
                    return _buildVisitedPlacesListView();
                  } else if (favoriteStore.visitedPlaces.isEmpty) {
                    return _buildEmptyVisitedPlaces();
                  }
                }
                return Center(child: CircularProgressIndicator(color: themeProvider.appTheme.inactiveColor));
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      title: Center(
        child: Text(
          AppStrings.favorites,
          style: appTypography.text24Bold.copyWith(
            color: themeProvider.appTheme.mainWhiteColor,
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: Material(
            color: themeProvider.appTheme.backgroundColor,
            borderRadius: BorderRadius.circular(40),
            child: const TabBar(
              tabs: [
                Tab(
                  text: AppStrings.iWantToVisit,
                ),
                Tab(
                  text: AppStrings.visited,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoritePlacesListView() {
    return ReorderableListView(
      onReorder: _onReorderPlan,
      children: favoriteStore.favoritePlaces.map((place) {
        return SightCardPlan(
          ValueKey(place.id),
          place,
        );
      }).toList(),
    );
  }

  Widget _buildEmptyFavoritePlaces() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.cardEmptyPage),
          sizedBox32H,
          Text(
            AppStrings.blank,
            style: appTypography.textGreyInactive18Bold,
          ),
          sizedBox8H,
          Text(
            AppStrings.favoritesPlace,
            style: appTypography.textGreyInactive14Regular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVisitedPlacesListView() {
    return ReorderableListView(
      onReorder: _onReorderVisited,
      children: favoriteStore.visitedPlaces.map((place) {
        return SightCardVisited(
          ValueKey(place.id),
          place,
        );
      }).toList(),
    );
  }

  Widget _buildEmptyVisitedPlaces() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.goEmptyPage),
          sizedBox32H,
          Text(
            AppStrings.blank,
            style: appTypography.textGreyInactive18Bold,
          ),
          sizedBox8H,
          Text(
            AppStrings.completedRoute,
            style: appTypography.textGreyInactive14Regular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _onReorderVisited(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final place = favoriteStore.visitedPlaces.removeAt(oldIndex);
      favoriteStore.visitedPlaces.insert(newIndex, place);
    });
  }

  void _onReorderPlan(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final place = favoriteStore.favoritePlaces.removeAt(oldIndex);
      favoriteStore.favoritePlaces.insert(newIndex, place);
    });
  }
}
