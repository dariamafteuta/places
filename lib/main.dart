import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
    var count = 0;
    count++;

    print(count);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hello!',
            ),
            Text(
              '${count}',
            ),
          ],
        ),
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
//     var count = 0;
//     count++;
//
//     print(count);
//
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Hello!',
//             ),
//             Text(
//               '${count}',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
