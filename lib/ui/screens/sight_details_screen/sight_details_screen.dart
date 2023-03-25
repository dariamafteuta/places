import 'package:flutter/material.dart';
import 'package:flutter_job/domain/sight.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/screens/sight_details_screen/images_slider.dart';
import 'package:flutter_job/ui/screens/sight_details_screen/sight_details.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SightDetailsScreen extends StatefulWidget {
  final Sight sight;

  const SightDetailsScreen({Key? key, required this.sight}) : super(key: key);

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
                sight: widget.sight,
                borderRadius: 0,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SightDetails(sight: widget.sight),
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
