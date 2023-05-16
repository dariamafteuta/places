import 'package:flutter/material.dart';
import 'package:flutter_job/data/iterator/favorite_provider.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SightDetails extends StatefulWidget {
  final Place place;

  const SightDetails({Key? key, required this.place}) : super(key: key);

  @override
  State<SightDetails> createState() => _SightDetailsState();
}

AppTypography appTypography = AppTypography();

class _SightDetailsState extends State<SightDetails> {
  bool isFavorite = false;

  @override
  void initState() {
    final favoriteProvider = Provider.of<FavoriteProvider>(
      context,
      listen: false,
    );

    super.initState();
    isFavorite = favoriteProvider.favoriteIdPlaces.contains(widget.place.id);
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(
      context,
      listen: false,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          sizedBox24H,
          _PlaceName(name: widget.place.name),
          sizedBox24H,
          _PlaceType(type: widget.place.placeType),
          sizedBox24H,
          _PlaceDetails(details: widget.place.description),
          sizedBox24H,
          const _BuildRouteButton(),
          Divider(
            height: 39,
            color: themeProvider.appTheme.inactiveColor,
            thickness: 0.8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset(
                  favoriteProvider.dataVisited[widget.place.id] != null
                      ? AppAssets.calendarFull
                      : AppAssets.calendar,
                  color: isFavorite
                      ? themeProvider.appTheme.secondaryWhiteColor
                      : themeProvider.appTheme.inactiveColor,
                ),
                label: Text(
                  AppStrings.plan,
                  style: isFavorite
                      ? appTypography.text14Regular.copyWith(
                          color: themeProvider.appTheme.secondaryWhiteColor,
                        )
                      : appTypography.textGreyInactive14Regular,
                ),
              ),
              sizedBox50W,
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;

                    if (isFavorite) {
                      favoriteProvider.favoriteIdPlaces.add(widget.place.id);
                      favoriteProvider.getFavoritePlace();
                    } else {
                      favoriteProvider.favoriteIdPlaces.remove(widget.place.id);
                      favoriteProvider.getFavoritePlace();
                    }
                  });
                },
                icon: SvgPicture.asset(
                  isFavorite ? AppAssets.heartFull : AppAssets.heart,
                  color: themeProvider.appTheme.secondaryWhiteColor,
                ),
                label: Text(
                  AppStrings.toFavorites,
                  style: appTypography.text14Regular.copyWith(
                    color: themeProvider.appTheme.secondaryWhiteColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlaceName extends StatelessWidget {
  final String name;

  const _PlaceName({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        name,
        style: appTypography.text24Bold.copyWith(
          color: themeProvider.appTheme.mainWhiteColor,
        ),
      ),
    );
  }
}

class _PlaceType extends StatelessWidget {
  final String type;

  const _PlaceType({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        type,
        style: appTypography.text14Bold
            .copyWith(color: themeProvider.appTheme.secondarySecondary2Color),
      ),
    );
  }
}

class _PlaceDetails extends StatelessWidget {
  final String details;

  const _PlaceDetails({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        details,
        style: appTypography.text14Regular.copyWith(
          color: themeProvider.appTheme.secondaryWhiteColor,
        ),
      ),
    );
  }
}

class _BuildRouteButton extends StatelessWidget {
  const _BuildRouteButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        icon: SvgPicture.asset(
          AppAssets.go,
          color: themeProvider.appTheme.whiteColor,
        ),
        label: Text(
          AppStrings.buildARoute,
          style: appTypography.text14Regular
              .copyWith(color: themeProvider.appTheme.whiteColor),
        ),
        style: TextButton.styleFrom(
          elevation: 0.0,
          backgroundColor: themeProvider.appTheme.greenColor,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
