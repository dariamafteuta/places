import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/new_place_screen/add_sight_screen.dart';
import 'package:flutter_svg/svg.dart';

class NewPlaceImage extends StatefulWidget {
  final Function(List<String>) images;

  const NewPlaceImage({Key? key, required this.images}) : super(key: key);

  @override
  State<NewPlaceImage> createState() => _NewPlaceImageState();
}

class _NewPlaceImageState extends State<NewPlaceImage> {
  int index = 0;
  List<String> listUrlImages = [];
  final text16BoldSecondary2Color = appTypography.text16Bold.copyWith(
    color: themeProvider.appTheme.secondary2WhiteColor,
  );
  final secondary2WhiteColor = themeProvider.appTheme.secondary2WhiteColor;
  final whiteMainColor = themeProvider.appTheme.whiteMainColor;
  final greenColor = themeProvider.appTheme.greenColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                addUrls(
                  'https://novostipmr.com/sites/default/files/filefield_paths/silverlake002.jpg',
                );
              });
              showModalBottomSheet<AddSightScreen>(
                context: context,
                backgroundColor: themeProvider.appTheme.transparentColor,
                builder: (_) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DecoratedBox(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  AppStrings.camera,
                                  style: text16BoldSecondary2Color,
                                ),
                                leading: SvgPicture.asset(
                                  AppAssets.camera,
                                  color: secondary2WhiteColor,
                                ),
                                onTap: () {},
                              ),
                              divider,
                              ListTile(
                                title: Text(
                                  AppStrings.photo,
                                  style: text16BoldSecondary2Color,
                                ),
                                leading: SvgPicture.asset(
                                  AppAssets.photo,
                                  color: secondary2WhiteColor,
                                ),
                                onTap: () {},
                              ),
                              divider,
                              ListTile(
                                title: Text(
                                  AppStrings.fail,
                                  style: text16BoldSecondary2Color,
                                ),
                                leading: SvgPicture.asset(
                                  AppAssets.fail,
                                  color: secondary2WhiteColor,
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: whiteMainColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        sizedBox8H,
                        SizedBox(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppStrings.cancel.toUpperCase(),
                              style: appTypography.text16Bold.copyWith(
                                color: themeProvider.appTheme.greenColor,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              elevation: 0.0,
                              backgroundColor: whiteMainColor,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          width: double.infinity,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              width: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: greenColor),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.plus,
                  color: greenColor,
                ),
              ),
            ),
          ),
          ...listUrlImages.map(
            (e) => ImageCard(
              url: e,
              removeUrl: removeUrl,
            ),
          ),
        ],
      ),
    );
  }

  void addUrls(String url) {
    setState(() {
      listUrlImages.add(url);

      widget.images(listUrlImages);
    });
  }

  void removeUrl(String url) {
    setState(() {
      listUrlImages.remove(url);

      widget.images(listUrlImages);
    });
  }
}

class ImageCard extends StatefulWidget {
  final String url;
  final Function(String) removeUrl;

  const ImageCard({
    Key? key,
    required this.url,
    required this.removeUrl,
  }) : super(key: key);

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Dismissible(
        key: ObjectKey(widget.url),
        direction: DismissDirection.vertical,
        onDismissed: (_) {
          widget.removeUrl(widget.url);
        },
        child: SizedBox(
          width: 72,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.url,
                    ),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned(
                right: 0,
                child: CupertinoButton(
                  minSize: 1,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      widget.removeUrl(widget.url);
                    });
                  },
                  child: SvgPicture.asset(
                    AppAssets.clear,
                    color: themeProvider.appTheme.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
