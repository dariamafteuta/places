import 'package:flutter/material.dart';
import 'package:flutter_job/domain/sight.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
      child: SingleChildScrollView(
        child: AspectRatio(
          aspectRatio: 3/2,
          child:
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Positioned(
                  top: 19,
                  right: 18,
                  child: Container(
                    height: 23,
                    width: 23,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 19,
                  left: 18,
                  child: Text(
                    sight.type,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                    height: 100,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 16),
                          alignment: Alignment.topLeft,
                          child: Text(
                            sight.name,
                            style: const TextStyle(
                              color: Color.fromRGBO(37, 40, 73, 1),
                              fontSize: 17,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 5,
                            right: 16,
                          ),
                          alignment: Alignment.topLeft,
                          child: Text(
                            sight.details,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color.fromRGBO(124, 126, 146, 1),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
