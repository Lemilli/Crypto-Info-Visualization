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
  late String imagePath;

  @override
  void initState() {
    switch (widget.semanticsType) {
      case SemanticsType.positive:
        semanticsTypeString = 'Positive';
        textColor = const Color(0xFF8BDA4D);

        if ((widget.latestSemantics[0].percentageOfPositiveTweets >=
                widget.latestSemantics[1].percentageOfPositiveTweets) &&
            widget.latestSemantics[0].percentageOfPositiveTweets >=
                widget.latestSemantics[2].percentageOfPositiveTweets) {
          imagePath = GlobalHelper.cryptoImages[0];
        } else if ((widget.latestSemantics[1].percentageOfPositiveTweets >
                widget.latestSemantics[0].percentageOfPositiveTweets) &&
            widget.latestSemantics[1].percentageOfPositiveTweets >=
                widget.latestSemantics[2].percentageOfPositiveTweets) {
          imagePath = GlobalHelper.cryptoImages[1];
        } else {
          imagePath = GlobalHelper.cryptoImages[2];
        }
        break;
      case SemanticsType.negative:
        semanticsTypeString = 'Negative';
        textColor = const Color(0xFFEB5252);

        if ((widget.latestSemantics[0].percentageOfNegativeTweets >=
                widget.latestSemantics[1].percentageOfNegativeTweets) &&
            widget.latestSemantics[0].percentageOfNegativeTweets >=
                widget.latestSemantics[2].percentageOfNegativeTweets) {
          imagePath = GlobalHelper.cryptoImages[0];
        } else if ((widget.latestSemantics[1].percentageOfNegativeTweets >
                widget.latestSemantics[0].percentageOfNegativeTweets) &&
            widget.latestSemantics[1].percentageOfNegativeTweets >=
                widget.latestSemantics[2].percentageOfNegativeTweets) {
          imagePath = GlobalHelper.cryptoImages[1];
        } else {
          imagePath = GlobalHelper.cryptoImages[2];
        }

        break;
      case SemanticsType.neutral:
        textColor = const Color(0xFFFFA859);
        semanticsTypeString = 'Neutral';

        if ((widget.latestSemantics[0].percentageOfNeutralTweets >=
                widget.latestSemantics[1].percentageOfNeutralTweets) &&
            widget.latestSemantics[0].percentageOfNeutralTweets >=
                widget.latestSemantics[2].percentageOfNeutralTweets) {
          imagePath = GlobalHelper.cryptoImages[0];
        } else if ((widget.latestSemantics[1].percentageOfNeutralTweets >
                widget.latestSemantics[0].percentageOfNeutralTweets) &&
            widget.latestSemantics[1].percentageOfNeutralTweets >=
                widget.latestSemantics[2].percentageOfNeutralTweets) {
          imagePath = GlobalHelper.cryptoImages[1];
        } else {
          imagePath = GlobalHelper.cryptoImages[2];
        }

        break;
    }

    _tooltipBehavior = TooltipBehavior(
      duration: 0,
      enable: true,
      format: 'point.x: point.y%',
      tooltipPosition: TooltipPosition.pointer,
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
        Stack(
          alignment: Alignment.center,
          children: [
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
                      GlobalHelper.cryptoNames[i],
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
                  pointColorMapper: (data, i) => GlobalHelper.cryptosColors[i],
                ),
              ],
            ),
            Image(
              image: AssetImage(imagePath),
              width: 50,
              height: 50,
            ),
          ],
        )
      ],
    );
  }
}
