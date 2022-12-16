import 'package:flutter/material.dart';
import 'package:flutter_job/mocks.dart';
import 'package:flutter_job/ui/screen/sight_details.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SightDetails(sight: mocks[0]),
    );
  }
}