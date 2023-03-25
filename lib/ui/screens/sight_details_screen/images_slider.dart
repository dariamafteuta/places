import 'package:flutter/cupertino.dart';
import 'package:flutter_job/domain/sight.dart';
import 'package:flutter_job/main.dart';

class ImagesSlider extends StatefulWidget {
  final Sight sight;
  final double borderRadius;

  const ImagesSlider({
    Key? key,
    required this.sight,
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
            itemCount: widget.sight.url.length,
            itemBuilder: (_, index) {
              return ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(widget.borderRadius),
                ),
                child: Image.network(
                  widget.sight.url[index],
                  loadingBuilder: (_, child, loadingProgress) =>
                      loadingProgress == null
                          ? child
                          : CupertinoActivityIndicator(
                              color: themeProvider.appTheme.inactiveColor,
                            ),
                  fit: BoxFit.cover,
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
                for (int i = 0; i < widget.sight.url.length; i += 1)
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
