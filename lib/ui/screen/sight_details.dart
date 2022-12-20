import 'package:flutter/material.dart';
import 'package:flutter_job/app_string.dart';
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
            children: const [
              Photos(),
              BackButton(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 17,
              right: 17,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                Container(
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
                const SizedBox(
                  height: 2,
                ),
                Container(
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
                const SizedBox(
                  height: 24,
                ),
                Container(
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
                const SizedBox(
                  height: 24,
                ),
                const BuildRouteButton(),
                const Divider(
                  height: 39,
                  color: Color.fromRGBO(124, 126, 146, 1),
                  thickness: 0.8,
                ),
                const PlanAndChosen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Photos extends StatelessWidget {
  const Photos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade400,
      height: 360,
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}

class BuildRouteButton extends StatelessWidget {
  const BuildRouteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 17,
        top: 15,
        right: 17,
        bottom: 15,
      ),
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
          const Text(
            AppString.buildARoute,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }
}

class PlanAndChosen extends StatelessWidget {
  const PlanAndChosen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Text(
          AppString.plan,
          style: TextStyle(
            color: Color.fromRGBO(124, 126, 146, 1),
            fontSize: 14,
            fontFamily: 'Roboto',
          ),
        ),
        Text(
          AppString.chosen,
          style: TextStyle(
            color: Color.fromRGBO(124, 126, 146, 1),
            fontSize: 14,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    );
  }
}
