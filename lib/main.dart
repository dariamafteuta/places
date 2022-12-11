import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyTwoWidget(),
    );
  }
}

class MyFirstWidget extends StatelessWidget {
  const MyFirstWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var counter = 0;
    counter++;
    // ignore: avoid_print
    print(counter);

    return Scaffold(
      body: Center(
        child: Text('Hello! $counter'),
      ),
    );
  }
}

class MyTwoWidget extends StatefulWidget {
  const MyTwoWidget({Key? key}) : super(key: key);

  @override
  State<MyTwoWidget> createState() => _MyTwoWidgetState();
}

class _MyTwoWidgetState extends State<MyTwoWidget> {
  @override
  Widget build(BuildContext context) {
    var counter = 0;
    counter++;
    // ignore: avoid_print
    print(counter);

    return Scaffold(
      body: Center(
        child: Text('Hello! $counter'),
      ),
    );
  }
}