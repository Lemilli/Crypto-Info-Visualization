import 'package:flutter/material.dart';
import 'package:infoviz_assign/models/cryptocurrency_model.dart';
import 'package:infoviz_assign/global_helper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

enum SemanticsType { positive, negative, neutral }

class SemanticsRadialBar extends StatelessWidget {
  SemanticsRadialBar({
    Key? key,
    required this.latestSemantics,
    required this.semanticsType,
  }) : super(key: key);

  final List<CryptocurrencyModel> latestSemantics;
  final SemanticsType semanticsType;
  late final String semanticsTypeString;
  late final Color textColor;
  late final TooltipBehavior _tooltipBehavior;
  late final String imagePath;

  void _setupData() {
    switch (semanticsType) {
      case SemanticsType.positive:
        semanticsTypeString = 'Positive';
        textColor = const Color(0xFF8BDA4D);

        if ((latestSemantics[0].percentageOfPositiveTweets >=
                latestSemantics[1].percentageOfPositiveTweets) &&
            latestSemantics[0].percentageOfPositiveTweets >=
                latestSemantics[2].percentageOfPositiveTweets) {
          imagePath = GlobalHelper.cryptoImages[0];
        } else if ((latestSemantics[1].percentageOfPositiveTweets >
                latestSemantics[0].percentageOfPositiveTweets) &&
            latestSemantics[1].percentageOfPositiveTweets >=
                latestSemantics[2].percentageOfPositiveTweets) {
          imagePath = GlobalHelper.cryptoImages[1];
        } else {
          imagePath = GlobalHelper.cryptoImages[2];
        }
        break;
      case SemanticsType.negative:
        semanticsTypeString = 'Negative';
        textColor = const Color(0xFFEB5252);

        if ((latestSemantics[0].percentageOfNegativeTweets >=
                latestSemantics[1].percentageOfNegativeTweets) &&
            latestSemantics[0].percentageOfNegativeTweets >=
                latestSemantics[2].percentageOfNegativeTweets) {
          imagePath = GlobalHelper.cryptoImages[0];
        } else if ((latestSemantics[1].percentageOfNegativeTweets >
                latestSemantics[0].percentageOfNegativeTweets) &&
            latestSemantics[1].percentageOfNegativeTweets >=
                latestSemantics[2].percentageOfNegativeTweets) {
          imagePath = GlobalHelper.cryptoImages[1];
        } else {
          imagePath = GlobalHelper.cryptoImages[2];
        }

        break;
      case SemanticsType.neutral:
        textColor = const Color(0xFFFFA859);
        semanticsTypeString = 'Neutral';

        if ((latestSemantics[0].percentageOfNeutralTweets >=
                latestSemantics[1].percentageOfNeutralTweets) &&
            latestSemantics[0].percentageOfNeutralTweets >=
                latestSemantics[2].percentageOfNeutralTweets) {
          imagePath = GlobalHelper.cryptoImages[0];
        } else if ((latestSemantics[1].percentageOfNeutralTweets >
                latestSemantics[0].percentageOfNeutralTweets) &&
            latestSemantics[1].percentageOfNeutralTweets >=
                latestSemantics[2].percentageOfNeutralTweets) {
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
  }

  @override
  Widget build(BuildContext context) {
    _setupData();

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
                  dataSource: latestSemantics,
                  enableTooltip: true,
                  cornerStyle: CornerStyle.bothCurve,
                  maximumValue: 100,
                  xValueMapper: (CryptocurrencyModel data, i) =>
                      GlobalHelper.cryptoNames[i],
                  yValueMapper: (CryptocurrencyModel data, _) {
                    switch (semanticsType) {
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
