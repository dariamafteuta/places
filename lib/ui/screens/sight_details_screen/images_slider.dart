import 'package:flutter/cupertino.dart';
import 'package:flutter_job/data/model/place.dart';
import 'package:flutter_job/data/settings_iterator/theme_provider.dart';

class ImagesSlider extends StatefulWidget {
  final Place place;
  final double borderRadius;

  const ImagesSlider({
    Key? key,
    required this.place,
    required this.borderRadius,
  }) : super(key: key);

  @override
  State<ImagesSlider> createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 360,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                _currentIndex = value;
              });
            },
            itemCount: widget.place.urls.length,
            itemBuilder: (_, index) {
              return ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(widget.borderRadius),
                ),
                child: Hero(
                  tag: 'image',
                  child: Image.network(
                    widget.place.urls[index],
                    loadingBuilder: (_, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : CupertinoActivityIndicator(
                                color: themeProvider.appTheme.inactiveColor,
                              ),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 8,
            child: Row(
              children: [
                for (int i = 0; i < widget.place.urls.length; i += 1)
                  Expanded(
                    child: i == _currentIndex
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: themeProvider.appTheme.mainWhiteColor,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
