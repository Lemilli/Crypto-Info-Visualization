import 'package:flutter/material.dart';
import 'package:infoviz_assign/global_helper.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'custom_cartesian_chart.dart';

class TrackballPopUpWidget extends StatelessWidget {
  TrackballPopUpWidget({
    Key? key,
    required this.trackballDetails,
    required this.type,
  }) : super(key: key);

  final TrackballDetails trackballDetails;
  final CartesianGraphType type;
  late final String displayedText;
  late final String cryptoName;
  late final Color? color;

  void _setupToGraphType() {
    switch (type) {
      case CartesianGraphType.price:
        displayedText = 'Price: ';
        break;
      case CartesianGraphType.tweetCount:
        displayedText = 'Tweet Count: ';
        break;
      case CartesianGraphType.semantics:
        displayedText = 'Semantics: ';
        break;
    }

    color = trackballDetails.series?.color;
    if (color == Colors.orange) {
      cryptoName = 'Bitcoin';
    } else if (color == Colors.grey) {
      cryptoName = 'Ethereum';
    } else if (color == Colors.blue) {
      cryptoName = 'Solana';
    }
  }

  @override
  Widget build(BuildContext context) {
    _setupToGraphType();

    return Container(
      height: 60,
      width: 156,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 8,
                width: 8,
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color ?? Colors.black,
                ),
              ),
              Text(
                cryptoName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text(
                'Date: ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                DateFormat('dd-MM-yyyy - HH:mm:ss')
                    .format(trackballDetails.point!.x),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                displayedText,
                style: const TextStyle(
                  color: Color.fromRGBO(158, 158, 158, 1),
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                type == CartesianGraphType.price
                    ? GlobalHelper.formatDecimalPattern(
                            trackballDetails.point!.y) +
                        r'$'
                    : GlobalHelper.formatDecimalPattern(
                        trackballDetails.point!.y),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
