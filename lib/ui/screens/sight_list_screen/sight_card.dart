import 'dart:async';

import 'package:drift/drift.dart' as dr;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/database/app_database.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SightCard extends StatefulWidget {
  final Place place;

  const SightCard(
    Key? key,
    this.place,
  ) : super(key: key);

  @override
  State<SightCard> createState() => _SightCardState();
}

class _SightCardState extends State<SightCard>
    with SingleTickerProviderStateMixin {
  final StreamController<List<int>> _favoritePlacesController =
      StreamController<List<int>>();
  Stream<List<int>> get favoritePlacesStream =>
      _favoritePlacesController.stream;

  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late AppDatabase appDatabase;

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  void _saveToFavoriteDb() {
    appDatabase.insertMyFavorite(
      FavoriteListCompanion(
        id: dr.Value(widget.place.id),
      ),
    );
  }

  void _deleteToFavoriteDb() {
    appDatabase.deleteMyFavorite(FavoriteListData(id: widget.place.id));

    _checkOfFavorite();
  }

  Future<bool> _checkOfFavorite() async {
    final favoriteList = await appDatabase.getMyFavoriteList();
    final visitedList = await appDatabase.getMyVisitedList();

    final favorite = favoriteList.any((favorite) => favorite.id == widget.place.id) || visitedList.any((visited) => visited.id == widget.place.id);

    if (favorite) {
      setState(() => isFavorite = favorite);
    }

    return favorite;
  }

  @override
  void dispose() {
    _favoritePlacesController.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appDatabase = Provider.of<AppDatabase>(context);
    _checkOfFavorite();
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.place.id;
    final urls = widget.place.urls;
    final whiteColor = themeProvider.appTheme.whiteColor;
    appDatabase = Provider.of<AppDatabase>(context);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: InkWell(
        onTap: () {
          AppNavigation.goToSightDetails(context, widget.place);
        },
        splashColor: themeProvider.appTheme.whiteMainColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Stack(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    return Opacity(
                      opacity: _opacityAnimation.value,
                      child: child,
                    );
                  },
                  child: Hero(
                    tag: 'imageHero_$id',
                    child: SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        child: Image.network(
                          urls[0],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (_, child, loadingProgress) {
                            if (loadingProgress == null) {
                              _controller.forward();

                              return child;
                            } else {
                              return Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: SvgPicture.asset(
                                    AppAssets.photo,
                                    color: themeProvider.appTheme.inactiveColor,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: FutureBuilder<bool>(
                      future: _checkOfFavorite(),
                      builder: (_, snapshot) {
                      return CupertinoButton(
                        child: SvgPicture.asset(
                          isFavorite ? AppAssets.heartFull : AppAssets.heart,
                          color: whiteColor,
                          height: 25,
                          width: 25,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;

                            isFavorite ? _saveToFavoriteDb() : _deleteToFavoriteDb();
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Text(
                    widget.place.placeType,
                    style: appTypography.text14w700.copyWith(
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
            Ink(
              decoration: BoxDecoration(
                color: themeProvider.appTheme.backgroundColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              height: 100,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.place.name,
                      style: appTypography.text16Bold.copyWith(
                        color: themeProvider.appTheme.secondaryWhiteColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 5,
                      right: 16,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.place.description,
                      overflow: TextOverflow.ellipsis,
                      style: appTypography.textGreyInactive14Regular,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
