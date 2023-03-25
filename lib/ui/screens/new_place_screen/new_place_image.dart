import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/mocks.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/constants.dart';
import 'package:flutter_job/ui/screens/new_place_screen/add_sight_screen.dart';
import 'package:flutter_svg/svg.dart';

class NewImage extends StatefulWidget {
  const NewImage({Key? key}) : super(key: key);

  @override
  State<NewImage> createState() => _NewImageState();
}

class _NewImageState extends State<NewImage> {
  final listUrlImage = <String>[];
  int index = 0;

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
                randomIndex();
                listUrlImage.add(mocks[index].url[0]);
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
                        Container(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  AppStrings.camera,
                                  style: appTypography.text16Bold.copyWith(
                                    color: themeProvider
                                        .appTheme.secondary2WhiteColor,
                                  ),
                                ),
                                leading: SvgPicture.asset(
                                  AppAssets.camera,
                                  color: themeProvider
                                      .appTheme.secondary2WhiteColor,
                                ),
                                onTap: () {},
                              ),
                              divider,
                              ListTile(
                                title: Text(
                                  AppStrings.photo,
                                  style: appTypography.text16Bold.copyWith(
                                    color: themeProvider
                                        .appTheme.secondary2WhiteColor,
                                  ),
                                ),
                                leading: SvgPicture.asset(
                                  AppAssets.photo,
                                  color: themeProvider
                                      .appTheme.secondary2WhiteColor,
                                ),
                                onTap: () {},
                              ),
                              divider,
                              ListTile(
                                title: Text(
                                  AppStrings.fail,
                                  style: appTypography.text16Bold.copyWith(
                                    color: themeProvider
                                        .appTheme.secondary2WhiteColor,
                                  ),
                                ),
                                leading: SvgPicture.asset(
                                  AppAssets.fail,
                                  color: themeProvider
                                      .appTheme.secondary2WhiteColor,
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: themeProvider.appTheme.whiteMainColor,
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
                              backgroundColor:
                                  themeProvider.appTheme.whiteMainColor,
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
                border: Border.all(color: themeProvider.appTheme.greenColor),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.plus,
                  color: themeProvider.appTheme.greenColor,
                ),
              ),
            ),
          ),
          ...listUrlImage.map(
            (e) => ImageCard(
              url: e,
              removeUrl: removeUrl,
            ),
          ),
        ],
      ),
    );
  }

  void removeUrl(String url) {
    setState(() {
      listUrlImage.remove(url);
    });
  }

  void randomIndex() {
    index = Random().nextInt(9);
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
