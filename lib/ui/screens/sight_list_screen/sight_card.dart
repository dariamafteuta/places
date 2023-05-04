import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/main.dart';
import 'package:flutter_job/ui/res/app_assets.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/screens/sight_details_screen/bottom_sheet_details.dart';
import 'package:flutter_job/ui/screens/sight_list_screen/sight_list_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppTypography appTypography = AppTypography();

class SightCard extends StatefulWidget {
  final Place place;

  const SightCard(
    Key? key,
    this.place,
  ) : super(key: key);

  @override
  State<SightCard> createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = placeIterator.favoriteIdPlaces.contains(widget.place.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: InkWell(
        onTap: () {
          showModalBottomSheet<SightListScreen>(
            isScrollControlled: true,
            isDismissible: false,
            context: context,
            backgroundColor: themeProvider.appTheme.transparentColor,
            builder: (_) {
              return BottomSheetDetails(
                sight: widget.place,
              );
            },
          );
        },
        splashColor: themeProvider.appTheme.whiteMainColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
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
                    child: Ink(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.place.urls.isNotEmpty
                                ? widget.place.urls[0]
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
                Positioned(
                  right: 0,
                  child: CupertinoButton(
                    child: SvgPicture.asset(
                      isFavorite ? AppAssets.heartFull : AppAssets.heart,
                      color: themeProvider.appTheme.whiteColor,
                      height: 25,
                      width: 25,
                    ),
                    onPressed: () {
                      setState(() {
                        placeIterator.visitedIdPlaces.contains(widget.place.id)
                            ? isFavorite = false
                            : isFavorite = !isFavorite;

                        if (isFavorite) {
                          placeIterator.favoriteIdPlaces.add(widget.place.id);
                          placeIterator.getFavoritePlace();
                        } else {
                          placeIterator.favoriteIdPlaces
                              .remove(widget.place.id);
                          placeIterator.getFavoritePlace();
                        }
                      });
                    },
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Text(
                    widget.place.placeType,
                    style: appTypography.text14w700.copyWith(
                      color: themeProvider.appTheme.whiteColor,
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
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.place.name,
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
                      widget.place.description,
                      overflow: TextOverflow.ellipsis,
                      style: appTypography.textGreyInactive14Regular,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
