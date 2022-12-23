import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/domain/sight.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_colors.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';

class SightDetails extends StatefulWidget {
  final Sight sight;

  const SightDetails({Key? key, required this.sight}) : super(key: key);

  @override
  State<SightDetails> createState() => _SightDetailsState();
}

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
                const Divider(
                  height: 39,
                  color: Color.fromRGBO(124, 126, 146, 1),
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
                : const CupertinoActivityIndicator(),
        fit: BoxFit.fitWidth,
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
      child: Container(
        width: 35,
        height: 35,
        child: Image.asset(AppAssets.left),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: AppColors.whiteColor,
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
        style: AppTypography.textTitle24Bold,
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
        style: AppTypography.textText14Bold,
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
        style: AppTypography.textText14Regular,
      ),
    );
  }
}

class _BuildRouteButton extends StatelessWidget {
  const _BuildRouteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 17,
        top: 15,
        right: 17,
        bottom: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.greenColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 23,
            width: 23,
            child: Image.asset(
              AppAssets.navigator,
              color: AppColors.whiteColor,
            ),
          ),
          const Text(
            AppString.buildARoute,
            style: AppTypography.textWhite14Regular,
          ),
        ],
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
        SizedBox(
          height: 21,
          width: 21,
          child: Image.asset(
            AppAssets.calendar,
            color: AppColors.greyColor,
          ),
        ),
        const Text(
          AppString.plan,
          style: AppTypography.textGrey14Regular,
        ),
        const SizedBox(
          width: 70,
        ),
        SizedBox(
          height: 21,
          width: 21,
          child: Image.asset(
            AppAssets.favorite,
            color: AppColors.greyColor,
          ),
        ),
        const Text(
          AppString.favorite,
          style: AppTypography.textGrey14Regular,
        ),
      ],
    );
  }
}
