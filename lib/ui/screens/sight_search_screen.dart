import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/content.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_list_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppTypography appTypography = AppTypography();
Set<Place> listSearch = {};

class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({Key? key}) : super(key: key);

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  final _searchController = TextEditingController();

  List<Place> searchResult = [];

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        leading: CupertinoButton(
          child: SvgPicture.asset(
            AppAssets.arrow,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.listOfInterestingPlaces,
          style: appTypography.text24Bold.copyWith(
            color: themeProvider.appTheme.mainWhiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              onEditingComplete: () => FocusScope.of(context).unfocus(),
              controller: _searchController,
              onChanged: (value) {
                placeIterator.getPlaces(null, null);

                setState(() {
                  searchResult.clear();

                  searchResult = placeIterator.searchPlaces(value);
                });
              },
              cursorWidth: 1,
              cursorColor: themeProvider.appTheme.mainWhiteColor,
              style: appTypography.text14Regular.copyWith(
                color: themeProvider.appTheme.mainWhiteColor,
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
                hintStyle:
                    TextStyle(color: themeProvider.appTheme.inactiveColor),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    AppAssets.search,
                    color: themeProvider.appTheme.inactiveColor,
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
                          setState(_searchController.clear);
                        },
                        child: SvgPicture.asset(
                          AppAssets.clear,
                          color: themeProvider.appTheme.mainWhiteColor,
                        ),
                      ),
              ),
            ),
            if (_searchController.text == '')
              const YourSearch()
            else if (searchResult.isEmpty)
              const SearchError()
            else
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (_, index) {
                    return Column(
                      children: List.generate(searchResult.length, (index) {
                        return SearchResult(
                          searchResult: searchResult[index],
                        );
                      }),
                    );
                  },
                ),
              ),
          ],
        ),
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

  const SearchResult({Key? key, required this.searchResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        highlightColor: themeProvider.appTheme.transparentColor,
        splashColor: themeProvider.appTheme.transparentColor,
        onTap: () {
          AppNavigation.goToSightDetails(context, searchResult);
          listSearch.add(searchResult);
        },
        child: Column(
          children: [
            Row(
              children: [
                Container(
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (listSearch.isNotEmpty)
            const Content(content: AppStrings.yourSearch),
          ...listSearch.map(
            (e) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e.name,
                      style: appTypography.text16Bold.copyWith(
                        color: themeProvider.appTheme.inactiveColor,
                      ),
                    ),
                    CupertinoButton(
                      child: SvgPicture.asset(
                        AppAssets.close,
                        color: themeProvider.appTheme.inactiveColor,
                      ),
                      onPressed: () {
                        setState(() {
                          listSearch.remove(e);
                        });
                      },
                    ),
                  ],
                ),
                divider,
              ],
            ),
          ),
          if (listSearch.isNotEmpty)
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(
                AppStrings.clearHistory,
                style: appTypography.text16Bold
                    .copyWith(color: themeProvider.appTheme.greenColor),
              ),
              onPressed: () {
                setState(() {
                  listSearch.clear();
                });
              },
            ),
        ],
      ),
    );
  }
}
