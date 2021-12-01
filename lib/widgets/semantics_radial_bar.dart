import 'package:flutter/material.dart';
import 'package:infoviz_assign/models/cryptocurrency_model.dart';
import 'package:infoviz_assign/variables.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

enum SemanticsType { positive, negative, neutral }

class SemanticsRadialBar extends StatefulWidget {
  const SemanticsRadialBar({
    Key? key,
    required this.latestSemantics,
    required this.semanticsType,
  }) : super(key: key);

  final List<CryptocurrencyModel> latestSemantics;
  final SemanticsType semanticsType;

  @override
  State<SemanticsRadialBar> createState() => _SemanticsRadialBarState();
}

class _SemanticsRadialBarState extends State<SemanticsRadialBar> {
  late String semanticsTypeString;
  late Color textColor;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    switch (widget.semanticsType) {
      case SemanticsType.positive:
        semanticsTypeString = 'Positive';
        textColor = const Color(0xFF8BDA4D);
        break;
      case SemanticsType.negative:
        semanticsTypeString = 'Negative';
        textColor = const Color(0xFFEB5252);
        break;
      case SemanticsType.neutral:
        textColor = const Color(0xFFFFA859);
        semanticsTypeString = 'Neutral';
        break;
    }

    _tooltipBehavior = TooltipBehavior(
      duration: 0,
      enable: true,
      format: 'point.x: point.y%',
      tooltipPosition: TooltipPosition.pointer,
      // Data here is CryptocurrencyModel
      // builder: (data, point, series, pointIndex, seriesIndex) {
      //   late String text;
      //   switch (widget.semanticsType) {
      //     case SemanticsType.positive:
      //       text = data.percentageOfPositiveTweets.toString();
      //       break;
      //     case SemanticsType.negative:
      //       text = data.percentageOfNegativeTweets.toString();
      //       break;
      //     case SemanticsType.neutral:
      //       text = data.percentageOfNeutralTweets.toString();
      //       break;
      //   }
      //   return Container(
      //     padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      //     color: Colors.black87,
      //     child: Text(text),
      //   );
      // },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: semanticsTypeString,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: ' Tweets',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' %',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SfCircularChart(
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            RadialBarSeries<CryptocurrencyModel, String>(
              gap: '5%',
              dataSource: widget.latestSemantics,
              enableTooltip: true,
              cornerStyle: CornerStyle.bothCurve,
              maximumValue: 100,
              xValueMapper: (CryptocurrencyModel data, i) =>
                  ConstVariables.cryptoNames[i],
              yValueMapper: (CryptocurrencyModel data, _) {
                switch (widget.semanticsType) {
                  case SemanticsType.positive:
                    return data.percentageOfPositiveTweets * 100;
                  case SemanticsType.negative:
                    return data.percentageOfNegativeTweets * 100;
                  case SemanticsType.neutral:
                    return data.percentageOfNeutralTweets * 100;
                }
              },
              pointColorMapper: (data, i) => ConstVariables.cryptosColors[i],
            ),
          ],
        )
      ],
    );
  }
}
