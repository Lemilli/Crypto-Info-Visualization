import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoviz_assign/global_helper.dart';
import 'package:infoviz_assign/models/cryptocurrency_model.dart';
import 'package:infoviz_assign/screens/home_page/bloc/cubit/cartesian_graph_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

enum CartesianGraphType {
  price,
  tweetCount,
  semantics,
}

class CustomCartesianChart extends StatelessWidget {
  const CustomCartesianChart({
    Key? key,
    required this.trackballBehavior,
    required this.zoomPanBehavior,
    required this.type,
    required this.isVisibleBTCPrice,
    required this.isVisibleETHPrice,
    required this.isVisibleSOLPrice,
  }) : super(key: key);

  final TrackballBehavior trackballBehavior;
  final ZoomPanBehavior zoomPanBehavior;
  final CartesianGraphType type;

  final bool isVisibleBTCPrice;
  final bool isVisibleETHPrice;
  final bool isVisibleSOLPrice;

  @override
  Widget build(BuildContext context) {
    final series = <LineSeries<CryptocurrencyModel, dynamic>>[];

    assert(BlocProvider.of<CartesianGraphCubit>(context).state
        is CartesianGraphChanged);
    final state = BlocProvider.of<CartesianGraphCubit>(context).state
        as CartesianGraphChanged;

    if (isVisibleBTCPrice) {
      series.add(LineSeries<CryptocurrencyModel, dynamic>(
        //enableTooltip: true,
        dataSource: state.bitcoins,
        xValueMapper: (CryptocurrencyModel data, index) => data.datetime,
        yValueMapper: (CryptocurrencyModel data, index) {
          switch (type) {
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

    if (isVisibleETHPrice) {
      series.add(LineSeries<CryptocurrencyModel, dynamic>(
        dataSource: state.ethereums,
        xValueMapper: (CryptocurrencyModel data, index) => data.datetime,
        yValueMapper: (CryptocurrencyModel data, index) {
          switch (type) {
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

    if (isVisibleSOLPrice) {
      series.add(LineSeries<CryptocurrencyModel, dynamic>(
        dataSource: state.solanas,
        xValueMapper: (CryptocurrencyModel data, index) => data.datetime,
        yValueMapper: (CryptocurrencyModel data, index) {
          switch (type) {
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
      enableAxisAnimation: false,
      trackballBehavior: trackballBehavior,
      zoomPanBehavior: zoomPanBehavior,
      series: series,
    );
  }
}
