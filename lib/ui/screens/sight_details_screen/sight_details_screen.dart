import 'package:flutter/material.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/screens/sight_details_screen/images_slider.dart';
import 'package:flutter_job/ui/screens/sight_details_screen/sight_details.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SightDetailsScreen extends StatefulWidget {
  final Place place;

  const SightDetailsScreen({Key? key, required this.place}) : super(key: key);

  @override
  State<SightDetailsScreen> createState() => _SightDetailsScreenState();
}

AppTypography appTypography = AppTypography();

class _SightDetailsScreenState extends State<SightDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            leading: const _BackButton(),
            flexibleSpace: FlexibleSpaceBar(
              background: ImagesSlider(
                place: widget.place,
                borderRadius: 0,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SightDetails(place: widget.place),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextButton(
        onPressed: () => Navigator.pop(context),
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
    );
  }
}
