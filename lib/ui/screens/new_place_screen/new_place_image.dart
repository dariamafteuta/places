import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/mocks.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
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
    return SingleChildScrollView(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                randomIndex();
                listUrlImage.add(mocks[index].url);
              });
            },
            child: Container(
              height: 72,
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
          height: 72,
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