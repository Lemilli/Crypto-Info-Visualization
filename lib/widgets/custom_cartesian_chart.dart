import 'package:flutter/material.dart';
import 'package:infoviz_assign/variables.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/cryptocurrency_model.dart';

enum CartesianGraphType {
  price,
  tweetCount,
  semantics,
}

class CustomCartesianChart extends StatefulWidget {
  const CustomCartesianChart({
    Key? key,
    required this.trackballBehavior,
    required this.zoomPanBehavior,
    required this.bitcoins,
    required this.ethereums,
    required this.solanas,
    required this.type,
  }) : super(key: key);

  final TrackballBehavior trackballBehavior;
  final ZoomPanBehavior zoomPanBehavior;
  final List<CryptocurrencyModel> bitcoins, ethereums, solanas;
  final CartesianGraphType type;

  @override
  State<CustomCartesianChart> createState() => _CustomCartesianChartState();
}

class _CustomCartesianChartState extends State<CustomCartesianChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      trackballBehavior: widget.trackballBehavior,
      zoomPanBehavior: widget.zoomPanBehavior,
      series: [
        LineSeries<CryptocurrencyModel, dynamic>(
          //enableTooltip: true,
          dataSource: widget.bitcoins,
          xValueMapper: (CryptocurrencyModel data, index) => data.datetime,
          yValueMapper: (CryptocurrencyModel data, index) {
            switch (widget.type) {
              case CartesianGraphType.price:
                return data.price;
              case CartesianGraphType.tweetCount:
                return data.keywordTweetNumber;
              case CartesianGraphType.semantics:
                return data.semanticsAll;
            }
          },
          color: ConstVariables.cryptosColors[0],
        ),
        LineSeries<CryptocurrencyModel, dynamic>(
          //enableTooltip: true,
          dataSource: widget.ethereums,
          xValueMapper: (CryptocurrencyModel data, index) => data.datetime,
          yValueMapper: (CryptocurrencyModel data, index) {
            switch (widget.type) {
              case CartesianGraphType.price:
                return data.price;
              case CartesianGraphType.tweetCount:
                return data.keywordTweetNumber;
              case CartesianGraphType.semantics:
                return data.semanticsAll;
            }
          },
          color: ConstVariables.cryptosColors[1],
        ),
        LineSeries<CryptocurrencyModel, dynamic>(
          //enableTooltip: true,
          dataSource: widget.solanas,
          xValueMapper: (CryptocurrencyModel data, index) => data.datetime,
          yValueMapper: (CryptocurrencyModel data, index) {
            switch (widget.type) {
              case CartesianGraphType.price:
                return data.price;
              case CartesianGraphType.tweetCount:
                return data.keywordTweetNumber;
              case CartesianGraphType.semantics:
                return data.semanticsAll;
            }
          },
          color: ConstVariables.cryptosColors[2],
        ),
      ],
    );
  }
}
