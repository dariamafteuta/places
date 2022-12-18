import 'package:flutter/material.dart';
import 'package:flutter_job/app_string.dart';
import 'package:flutter_job/mocks.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 180,
        title: const Padding(
          padding: EdgeInsets.only(left: 4, top: 40),
          child: Text(
            AppString.appBar,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              fontSize: 40,
              color: Color.fromRGBO(37, 40, 71, 1.0),
            ),
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
