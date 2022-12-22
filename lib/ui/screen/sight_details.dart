import 'package:flutter/cupertino.dart';
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
            children: [
              Photos(
                sight: widget.sight,
              ),
              const BackButton(),
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
                PlaceName(sight: widget.sight),
                const SizedBox(
                  height: 2,
                ),
                PlaceType(sight: widget.sight),
                const SizedBox(
                  height: 24,
                ),
                PlaceDetails(sight: widget.sight),
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
  final Sight sight;

  const Photos({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 360,
      child: Image.network(
        sight.url,
        loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress == null ? child : const CupertinoActivityIndicator(),
        fit: BoxFit.fitWidth,
      ),
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
        child: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
        ),
      ),
    );
  }
}

class PlaceName extends StatelessWidget {
  final Sight sight;

  const PlaceName({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        sight.name,
        style: const TextStyle(
          color: Color.fromRGBO(37, 40, 73, 1),
          fontSize: 24,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PlaceType extends StatelessWidget {
  final Sight sight;

  const PlaceType({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        sight.type,
        style: const TextStyle(
          color: Color.fromRGBO(37, 40, 73, 1),
          fontSize: 14,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PlaceDetails extends StatelessWidget {
  final Sight sight;

  const PlaceDetails({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        sight.details,
        style: const TextStyle(
          color: Color.fromRGBO(37, 40, 73, 1),
          fontSize: 14,
          fontFamily: 'Roboto',
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
        children: const [
          Icon(Icons.route_rounded, color: Colors.white,),
          Text(
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.calendar_month_rounded, color: Colors.grey,),
        Text(
          AppString.plan,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontFamily: 'Roboto',
          ),
        ),
        SizedBox(width: 70,),
        Icon(Icons.favorite_border_rounded, color: Colors.grey,),
        Text(
          AppString.chosen,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    );
  }
}
