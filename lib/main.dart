import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
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
        child: Text('Hello! \n$counter'),
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

  String typeOfContext() {
    return context.runtimeType.toString();
  }

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    counter++;
    // ignore: avoid_print
    print(counter);

    return Scaffold(
      body: Center(
        child: Text('Hello! \n$counter '),
      ),
    );
  }
}