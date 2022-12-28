import 'package:flutter/material.dart';
import 'package:flutter_job/mocks.dart';
import 'package:flutter_job/ui/res/app_strings.dart';
import 'package:flutter_job/ui/screen/sight_details.dart';
import 'package:flutter_job/ui/screen/sight_list_screen.dart';
import 'package:flutter_job/ui/screen/visiting_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      home: VisitingScreen(),
    );
  }
}
