import 'package:flutter/material.dart';
import 'package:flutter_job/mocks.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/res/app_typography.dart';
import 'package:flutter_job/ui/screen/sight_card.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 180,
        title: const Padding(
          padding: EdgeInsets.only(left: 4, top: 40),
          child: Text(
            AppStrings.appBar,
            textAlign: TextAlign.left,
            style: AppTypography.text40Bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SightCard(sight: mocks[0]),
          SightCard(sight: mocks[1]),
        ],
      ),
    );
  }
}
