import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/domain/sight.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SightDetails extends StatefulWidget {
  final Sight sight;

  const SightDetails({Key? key, required this.sight}) : super(key: key);

  @override
  State<SightDetails> createState() => _SightDetailsState();
}

AppTypography appTypography = AppTypography();

class _SightDetailsState extends State<SightDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              _Photos(sight: widget.sight),
              const _BackButton(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              children: [
                const SizedBox(height: 24),
                _PlaceName(sight: widget.sight),
                const SizedBox(height: 2),
                _PlaceType(sight: widget.sight),
                const SizedBox(height: 24),
                _PlaceDetails(sight: widget.sight),
                const SizedBox(height: 24),
                const _BuildRouteButton(),
                Divider(
                  height: 39,
                  color: themeProvider.appTheme.inactiveColor,
                  thickness: 0.8,
                ),
                const _PlanAndChosen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Photos extends StatelessWidget {
  final Sight sight;
  const _Photos({Key? key, required this.sight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 360,
      child: Image.network(
        sight.url,
        loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress == null
                ? child
                : CupertinoActivityIndicator(
                    color: themeProvider.appTheme.inactiveColor,
                  ),
        fit: BoxFit.cover,
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 17,
      child: SizedBox(
        height: 35,
        width: 35,
        child: TextButton(
          onPressed: () {
            if (kDebugMode) {
              print('Button Pressed');
            }
          },
          child: SvgPicture.asset(
            AppAssets.arrow,
            color: themeProvider.appTheme.mainWhiteColor,
          ),
          style: TextButton.styleFrom(
            elevation: 0.0,
            backgroundColor: themeProvider.appTheme.whiteMainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaceName extends StatelessWidget {
  final Sight sight;
  const _PlaceName({Key? key, required this.sight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        sight.name,
        style: appTypography.text24Bold.copyWith(
          color: themeProvider.appTheme.mainWhiteColor,
        ),
      ),
    );
  }
}

class _PlaceType extends StatelessWidget {
  final Sight sight;

  const _PlaceType({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        sight.type,
        style: appTypography.text14Bold
            .copyWith(color: themeProvider.appTheme.secondarySecondary2Color),
      ),
    );
  }
}

class _PlaceDetails extends StatelessWidget {
  final Sight sight;

  const _PlaceDetails({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        sight.details,
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
              .copyWith(
                color: themeProvider.appTheme.secondaryWhiteColor,
              )
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
        onPressed: () {
          if (kDebugMode) {
            print('ElevatedButton Pressed');
          }
        },
      ),
    );
  }
}

class _PlanAndChosen extends StatelessWidget {
  const _PlanAndChosen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: () {
            if (kDebugMode) {
              print('Calendar Pressed');
            }
          },
          icon: SvgPicture.asset(
            AppAssets.calendar,
            color: themeProvider.appTheme.inactiveColor,
          ),
          label: Text(
            AppStrings.plan,
            style: appTypography.textGreyInactive14Regular,
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        TextButton.icon(
          onPressed: () {
            if (kDebugMode) {
              print('Heart Pressed');
            }
          },
          icon: SvgPicture.asset(
            AppAssets.heart,
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
    );
  }
}
