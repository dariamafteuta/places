import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job/data/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:flutter_job/data/bloc/favorite_bloc/favorite_event.dart';
import 'package:flutter_job/data/bloc/favorite_bloc/favorite_state.dart';
import 'package:flutter_job/data/bloc/visited_bloc/visited_bloc.dart';
import 'package:flutter_job/data/bloc/visited_bloc/visited_event.dart';
import 'package:flutter_job/data/bloc/visited_bloc/visited_state.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/data/store/favorite_store_base.dart';
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

  Widget _buildPage() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(),
        bottomNavigationBar: const BottomNavigation(index: 2),
        body: TabBarView(
          children: [
            Builder(builder: (_) => _buildFavoritePlacesTab()),
            Builder(builder: (_) => _buildVisitedPlacesTab()),
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

  Widget _buildFavoritePlacesTab() {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (_, state) {
        if (state is FavoritePlaceLoaded) {
          return favoriteStore.favoritePlaces.isNotEmpty
              ? _buildFavoritePlacesListView()
              : _buildEmptyFavoritePlaces();
        }

        return Center(
          child: CircularProgressIndicator(
            color: themeProvider.appTheme.inactiveColor,
          ),
        );
      },
    );
  }

  Widget _buildVisitedPlacesTab() {
    return BlocBuilder<VisitedBloc, VisitedState>(
      builder: (_, state) {
        if (state is VisitedPlaceLoaded) {
          return favoriteStore.visitedPlaces.isNotEmpty
              ? _buildVisitedPlacesListView()
              : _buildEmptyVisitedPlaces();
        }

        return Center(
          child: CircularProgressIndicator(
            color: themeProvider.appTheme.inactiveColor,
          ),
        );
      },
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
      var adjustedIndex = newIndex;
      if (newIndex > oldIndex) {
        adjustedIndex -= 1;
      }
      final place = favoriteStore.visitedPlaces.removeAt(oldIndex);
      favoriteStore.visitedPlaces.insert(adjustedIndex, place);
    });
  }

  void _onReorderPlan(int oldIndex, int newIndex) {
    setState(() {
      var adjustedIndex = newIndex;
      if (newIndex > oldIndex) {
        adjustedIndex -= 1;
      }
      final place = favoriteStore.favoritePlaces.removeAt(oldIndex);
      favoriteStore.favoritePlaces.insert(adjustedIndex, place);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    favoriteStore = Provider.of<FavoriteStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoriteBloc>(
          create: (_) => FavoriteBloc(favoriteStore)..add(FetchFavorite()),
        ),
        BlocProvider<VisitedBloc>(
          create: (_) => VisitedBloc(favoriteStore)..add(FetchVisited()),
        ),
      ],
      child: Builder(builder: (_) => _buildPage()),
    );
  }
}
