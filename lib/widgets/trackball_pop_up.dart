import 'package:flutter/material.dart';
import 'package:infoviz_assign/variables.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'custom_cartesian_chart.dart';

class TrackballPopUpWidget extends StatefulWidget {
  const TrackballPopUpWidget({
    Key? key,
    required this.trackballDetails,
    required this.type,
  }) : super(key: key);

  final TrackballDetails trackballDetails;
  final CartesianGraphType type;

  @override
  State<TrackballPopUpWidget> createState() => _TrackballPopUpWidgetState();
}

class _TrackballPopUpWidgetState extends State<TrackballPopUpWidget> {
  late String displayedText;
  late String cryptoName;
  late Color color;

  @override
  void initState() {
    switch (widget.type) {
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

    switch (widget.trackballDetails.seriesIndex) {
      case 0:
        cryptoName = 'Bitcoin';
        color = ConstVariables.cryptosColors[0];
        break;
      case 1:
        cryptoName = 'Ethereum';
        color = ConstVariables.cryptosColors[1];
        break;
      case 2:
        cryptoName = 'Solana';
        color = ConstVariables.cryptosColors[2];
        break;
      default:
        cryptoName = 'Bitcoin';
        color = ConstVariables.cryptosColors[0];
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                  color: color,
                ),
              ),
              Text(
                cryptoName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'Poppins',
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
                ),
              ),
              Text(
                DateFormat('dd-MM-yyyy - HH:mm:ss')
                    .format(widget.trackballDetails.point!.x),
                style: const TextStyle(
                  fontSize: 10,
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
                  color: Colors.grey,
                  fontSize: 10,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                widget.type == CartesianGraphType.price
                    ? '${widget.trackballDetails.point!.y}\$'
                    : '${widget.trackballDetails.point!.y}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}