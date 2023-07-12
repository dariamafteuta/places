import 'package:flutter/cupertino.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/screens/sight_details_screen/images_slider.dart';
import 'package:flutter_job/ui/screens/sight_details_screen/sight_details.dart';
import 'package:flutter_svg/svg.dart';

class BottomSheetDetails extends StatelessWidget {
  final Place place;

  const BottomSheetDetails({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      builder: (context, controller) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: themeProvider.appTheme.whiteMainColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          child: Stack(
            children: [
              ListView(
                controller: controller,
                children: [
                  ImagesSlider(
                    place: place,
                    borderRadius: 12,
                  ),
                  SightDetails(place: place),
                ],
              ),
              IgnorePointer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 12,
                      ),
                      height: 4,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: themeProvider.appTheme.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(AppAssets.cardClose),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
