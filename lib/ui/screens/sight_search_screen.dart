import 'package:drift/drift.dart' as dr;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job/bloc/search_bloc/search_bloc.dart';
import 'package:flutter_job/bloc/search_bloc/search_event.dart';
import 'package:flutter_job/bloc/search_bloc/search_state.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/repository/place_repository.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/data/store/search_place_store_base.dart';
import 'package:flutter_job/database/app_database.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({Key? key}) : super(key: key);

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  final _searchController = TextEditingController();
  late SearchBloc searchBloc;

  String searchText = '';

  @override
  void initState() {
    super.initState();
    searchBloc =
        SearchBloc(Provider.of<SearchPlaceStore>(context, listen: false));
  }

  @override
  void dispose() {
    searchBloc.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainWhiteColor = themeProvider.appTheme.mainWhiteColor;
    final inactiveColor = themeProvider.appTheme.inactiveColor;

    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>.value(
          value: searchBloc,
        ),
      ],
      child: Builder(
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              centerTitle: true,
              leading: CupertinoButton(
                child: SvgPicture.asset(
                  AppAssets.arrow,
                  color: mainWhiteColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                AppStrings.listOfInterestingPlaces,
                style: appTypography.text24Bold.copyWith(
                  color: mainWhiteColor,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  Listener(
                    onPointerDown: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    child: TextField(
                      autofocus: true,
                      controller: _searchController,
                      onChanged: (value) {
                        searchText = value;

                        searchBloc.add(PerformSearch(searchText));
                      },
                      cursorWidth: 1,
                      cursorColor: mainWhiteColor,
                      style: appTypography.text14Regular.copyWith(
                        color: mainWhiteColor,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: themeProvider.appTheme.backgroundColor,
                        filled: true,
                        hintText: AppStrings.search,
                        hintStyle: TextStyle(color: inactiveColor),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            AppAssets.search,
                            color: inactiveColor,
                          ),
                        ),
                        suffixIcon: _searchController.text.isEmpty
                            ? CupertinoButton(
                                onPressed: () {
                                  AppNavigation.goToFilter(context);
                                },
                                padding: EdgeInsets.zero,
                                child: SvgPicture.asset(
                                  AppAssets.filter,
                                  color: themeProvider.appTheme.greenColor,
                                ),
                              )
                            : CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    searchText = '';
                                  });
                                },
                                child: SvgPicture.asset(
                                  AppAssets.clear,
                                  color: mainWhiteColor,
                                ),
                              ),
                      ),
                    ),
                  ),
                  BlocBuilder<SearchBloc, SearchState>(
                    bloc: searchBloc,
                    builder: (context, state) {
                      if (state is SearchResultsState) {
                        final searchResults = state.searchResults;

                        return searchResults.isEmpty
                            ? const SearchError()
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: searchResults.length,
                                  itemBuilder: (_, index) {
                                    return SearchResult(
                                      searchResult: searchResults[index],
                                    );
                                  },
                                ),
                              );
                      } else if (state is SearchErrorState) {
                        return const SearchError();
                      }

                      return const YourSearch();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchError extends StatelessWidget {
  const SearchError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.searchEmptyPage,
          ),
          sizedBox32H,
          Text(
            AppStrings.notFound,
            style: appTypography.textGreyInactive18Bold,
          ),
          sizedBox8H,
          Text(
            AppStrings.changeParameters,
            style: appTypography.textGreyInactive14Regular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  final Place searchResult;

  SearchResult({Key? key, required this.searchResult}) : super(key: key);

  late AppDatabase searchDatabase;

  void _saveToSearchDb() {
    searchDatabase.insertMySearch(
      SearchListCompanion(
        id: dr.Value(searchResult.id),
        name: dr.Value(searchResult.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final transparentColor = themeProvider.appTheme.transparentColor;
    searchDatabase = Provider.of<AppDatabase>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        highlightColor: transparentColor,
        splashColor: transparentColor,
        onTap: () {
          AppNavigation.goToSightDetails(context, searchResult);
          _saveToSearchDb();
        },
        child: Column(
          children: [
            Row(
              children: [
                Hero(
                  tag: 'imageHero_${searchResult.id}',
                  child: Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          searchResult.urls.isNotEmpty
                              ? searchResult.urls[0]
                              : 'https://www.sirvisual.com/Attachment/100/5055_31356_420%20Principale.jpg',
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                sizedBox10W,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        searchResult.name,
                        style: appTypography.text16Bold.copyWith(
                          color: themeProvider.appTheme.mainWhiteColor,
                        ),
                      ),
                      Text(
                        searchResult.placeType,
                        style: appTypography.text14Regular.copyWith(
                          color: themeProvider.appTheme.inactiveColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            divider,
          ],
        ),
      ),
    );
  }
}

class YourSearch extends StatefulWidget {
  const YourSearch({
    Key? key,
  }) : super(key: key);

  @override
  State<YourSearch> createState() => _YourSearchState();
}

class _YourSearchState extends State<YourSearch> {
  late AppDatabase searchDatabase;

  Future<List<SearchListData>> _getSearchFromDatabase() {
    return searchDatabase.getMySearchList();
  }

  @override
  Widget build(BuildContext context) {
    final inactiveColor = themeProvider.appTheme.inactiveColor;
    searchDatabase = Provider.of<AppDatabase>(context);

    return FutureBuilder<List<SearchListData>>(
      future: _getSearchFromDatabase(),
      builder: (_, snapshot) {
        final searchList = snapshot.data;

        return searchList != null && searchList.isNotEmpty
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: ListView.builder(
                    itemCount: searchList.length,
                    itemBuilder: (_, index) {
                      final searchData = searchList[index];

                      return Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CupertinoButton(
                              child: Text(
                                searchData.name,
                                style: appTypography.text16Bold
                                    .copyWith(color: inactiveColor),
                              ),
                              onPressed: () {
                                PlaceRepository()
                                    .getPlaceId(searchData.id)
                                    .then(
                                      (value) => AppNavigation.goToSightDetails(
                                        context,
                                        value,
                                      ),
                                    );
                              },
                            ),
                            CupertinoButton(
                              child: SvgPicture.asset(
                                AppAssets.close,
                                color: inactiveColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  searchDatabase.deleteMySearch(
                                    SearchListData(
                                      id: searchData.id,
                                      name: searchData.name,
                                    ),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                        divider,
                        if (index == searchList.length - 1)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Text(
                                AppStrings.clearHistory,
                                style: appTypography.text16Bold.copyWith(
                                  color: themeProvider.appTheme.greenColor,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  searchDatabase.searchList.deleteAll();
                                });
                              },
                            ),
                          ),
                      ]);
                    },
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
