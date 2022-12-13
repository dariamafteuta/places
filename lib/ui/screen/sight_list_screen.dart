import 'package:flutter/material.dart';

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
        toolbarHeight: 200,
        title: RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'C',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  color: Colors.green,
                ),
              ),
              TextSpan(
                text: 'писок\n',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  color: Color.fromRGBO(59, 62, 89, 1.0),
                ),
              ),
              TextSpan(
                text: 'и',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  color: Colors.yellow,
                ),
              ),
              TextSpan(
                text: 'нтересных мест',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  color: Color.fromRGBO(59, 62, 89, 1.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
