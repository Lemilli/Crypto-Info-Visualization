import 'package:flutter/material.dart';
import 'package:infoviz_assign/global_helper.dart';
import 'package:infoviz_assign/models/cryptocurrency_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    required this.isVisibleBTCPrice,
    required this.isVisibleETHPrice,
    required this.isVisibleSOLPrice,
  }) : super(key: key);

  final TrackballBehavior trackballBehavior;
  final ZoomPanBehavior zoomPanBehavior;
  final List<CryptocurrencyModel> bitcoins, ethereums, solanas;
  final CartesianGraphType type;

  final bool isVisibleBTCPrice;
  final bool isVisibleETHPrice;
  final bool isVisibleSOLPrice;

  @override
  State<CustomCartesianChart> createState() => _CustomCartesianChartState();
}

class _CustomCartesianChartState extends State<CustomCartesianChart> {
  @override
  Widget build(BuildContext context) {
    final series = <LineSeries<CryptocurrencyModel, dynamic>>[];

    if (widget.isVisibleBTCPrice) {
      series.add(LineSeries<CryptocurrencyModel, dynamic>(
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
        color: GlobalHelper.cryptosColors[0],
      ));
    }

    if (widget.isVisibleETHPrice) {
      series.add(LineSeries<CryptocurrencyModel, dynamic>(
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
        color: GlobalHelper.cryptosColors[1],
      ));
    }

    if (widget.isVisibleSOLPrice) {
      series.add(LineSeries<CryptocurrencyModel, dynamic>(
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
        color: GlobalHelper.cryptosColors[2],
      ));
    }

    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      trackballBehavior: widget.trackballBehavior,
      zoomPanBehavior: widget.zoomPanBehavior,
      series: series,
    );
  }
}
