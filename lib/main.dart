import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFirstWidget(),
    );
  }
}

class MyFirstWidget extends StatelessWidget {
  const MyFirstWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('${context.runtimeType}'),
      ),
    );
  }
}

// class MyTwoWidget extends StatefulWidget {
//   const MyTwoWidget({Key? key}) : super(key: key);
//
//   @override
//   State<MyTwoWidget> createState() => _MyTwoWidgetState();
// }
//
// class _MyTwoWidgetState extends State<MyTwoWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text('${context.runtimeType}'),
//       ),
//     );
//   }
// }
