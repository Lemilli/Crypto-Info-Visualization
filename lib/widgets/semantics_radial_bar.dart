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
          series: <CircularSeries>[
            RadialBarSeries<CryptocurrencyModel, String>(
              dataSource: widget.latestSemantics,
              enableTooltip: true,
              sortFieldValueMapper: (data, index) => data.price.toString(),
              cornerStyle: CornerStyle.bothCurve,
              xValueMapper: (CryptocurrencyModel data, _) =>
                  data.price.toString(), // not important
              yValueMapper: (CryptocurrencyModel data, _) {
                switch (widget.semanticsType) {
                  case SemanticsType.positive:
                    return data.percentageOfPositiveTweets;
                  case SemanticsType.negative:
                    return data.percentageOfNegativeTweets;
                  case SemanticsType.neutral:
                    return data.percentageOfNeutralTweets;
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
