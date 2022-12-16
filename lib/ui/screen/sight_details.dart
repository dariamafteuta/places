import 'package:flutter/material.dart';
import 'package:flutter_job/domain/sight.dart';

class SightDetails extends StatefulWidget {
  final Sight sight;

  const SightDetails({Key? key, required this.sight}) : super(key: key);

  @override
  State<SightDetails> createState() => _SightDetailsState();
}

class _SightDetailsState extends State<SightDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                color: Colors.grey.shade400,
                height: 360,
              ),
              Positioned(
                top: 40,
                left: 17,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 17, top: 24),
            alignment: Alignment.topLeft,
            child: Text(
              widget.sight.name,
              style: const TextStyle(
                color: Color.fromRGBO(37, 40, 73, 1),
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 17, top: 2),
            alignment: Alignment.topLeft,
            child: Text(
              widget.sight.type,
              style: const TextStyle(
                color: Color.fromRGBO(37, 40, 73, 1),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 17, top: 24, right: 17),
            alignment: Alignment.topLeft,
            child: Text(
              widget.sight.details,
              style: const TextStyle(
                color: Color.fromRGBO(37, 40, 73, 1),
                fontSize: 14,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17, top: 24, right: 17),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 17, top: 15, right: 17, bottom: 15,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.green,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 7),
                    child: Text(
                      'ПОСТРОИТЬ МАРШРУТ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 39,
            color: Color.fromRGBO(124, 126, 146, 1),
            indent: 16,
            endIndent: 16,
            thickness: 0.8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                'Запланировать',
                style: TextStyle(
                  color: Color.fromRGBO(124, 126, 146, 1),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                ),
              ),
              Text(
                'Избранное',
                style: TextStyle(
                  color: Color.fromRGBO(124, 126, 146, 1),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
