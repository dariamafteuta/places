import 'package:flutter/cupertino.dart';
import 'package:flutter_job/ui/screens/filters_screen.dart';

class Content extends StatelessWidget {
  final String content;

  const Content({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        content.toUpperCase(),
        style: appTypography.textGreyInactive14Regular,
      ),
    );
  }
}