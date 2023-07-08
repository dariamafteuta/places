import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/data/store/favorite_store_base.dart';
import 'package:flutter_job/ui/components/card_delete_background.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_navigation.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SightCardVisited extends StatefulWidget {
  final Place visitedPlace;

  const SightCardVisited(
    Key? key,
    this.visitedPlace,
  ) : super(key: key);

  @override
  State<SightCardVisited> createState() => _SightCardVisitedState();
}

class _SightCardVisitedState extends State<SightCardVisited> {
  final whiteColor = themeProvider.appTheme.whiteColor;

  String _dataString() {
    final favoriteStore = Provider.of<FavoriteStore>(context, listen: false);

    final data = favoriteStore.dataVisited[widget.visitedPlace.id];

    return 'Цель достигнута ${data?.day} ${data?.month} ${data?.year}';
  }

  @override
  Widget build(BuildContext context) {
    final urls = widget.visitedPlace.urls;
    final favoriteStore = Provider.of<FavoriteStore>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: InkWell(
        onTap: () {
          AppNavigation.goToSightDetails(context, widget.visitedPlace);
        },
        splashColor: themeProvider.appTheme.whiteMainColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (_) {
            favoriteStore
              ..removePlace(widget.visitedPlace)
              ..getFavoritePlace();
          },
          background: CardDeleteBackground(),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: Hero(
                        tag: 'imageHero_${widget.visitedPlace.id}',
                        child: Ink(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                urls.isNotEmpty
                                    ? urls[0]
                                    : 'https://www.sirvisual.com/Attachment/100/5055_31356_420%20Principale.jpg',
                              ),
                              fit: BoxFit.fitWidth,
                            ),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      right: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CupertinoButton(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            AppAssets.share,
                            color: whiteColor,
                          ),
                          onPressed: () {},
                        ),
                        CupertinoButton(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            AppAssets.close,
                            color: whiteColor,
                          ),
                          onPressed: () {
                            favoriteStore
                              ..removePlace(widget.visitedPlace)
                              ..getFavoritePlace();
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Text(
                      widget.visitedPlace.placeType,
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
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.visitedPlace.name,
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
                        _dataString(),
                        style: appTypography.textGreyInactive14Regular,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
