import 'package:flutter/material.dart';
import 'package:infoviz_assign/models/cryptocurrency_model.dart';
import 'package:infoviz_assign/global_widgets/info_tooltip.dart';
import 'package:infoviz_assign/global_helper.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PriceStatsWidget extends StatelessWidget {
  PriceStatsWidget({
    Key? key,
    required this.width,
    required this.cryptoModel,
    required this.imagePath,
    required this.cryptoName,
  }) : super(key: key);

  final double width;
  final CryptocurrencyModel cryptoModel;
  final String imagePath;
  final String cryptoName;

  Color _colorFromPercent(percent) {
    if (percent < 0.33) {
      return const Color(0xFFEB5252);
    } else if (percent < 0.65) {
      return const Color(0xFFFFA859);
    }
    return const Color(0xFF72E968);
  }

  @override
  Widget build(BuildContext context) {
    final pricePercent = ((cryptoModel.price - cryptoModel.lowPrice24H) /
            (cryptoModel.highPrice24H - cryptoModel.lowPrice24H))
        .clamp(0.0, 1.0);
    return Container(
      width: width * 0.25,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF8),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: AssetImage(imagePath),
                width: 26,
                height: 26,
              ),
              const SizedBox(width: 4),
              Text(
                cryptoName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Price Change in 24 hours',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              InfoTooltip(
                preferBelow: false,
                richMessage: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Lowest price in 24 hours: ',
                      style: TextStyle(color: Colors.white54),
                    ),
                    TextSpan(
                      text: GlobalHelper.formatDecimalPattern(
                          cryptoModel.lowPrice24H),
                      style: const TextStyle(),
                    ),
                    const TextSpan(
                      text: r'$',
                      style: TextStyle(color: Colors.white54),
                    ),
                    const TextSpan(text: '\n'),
                    const TextSpan(
                      text: 'Current Price: ',
                      style: TextStyle(color: Colors.white54),
                    ),
                    TextSpan(
                      text:
                          GlobalHelper.formatDecimalPattern(cryptoModel.price),
                      style: const TextStyle(),
                    ),
                    const TextSpan(
                      text: r'$',
                      style: TextStyle(color: Colors.white54),
                    ),
                    const TextSpan(text: '\n'),
                    const TextSpan(
                      text: 'Highest price in 24 hours: ',
                      style: TextStyle(color: Colors.white54),
                    ),
                    TextSpan(
                      text: GlobalHelper.formatDecimalPattern(
                          cryptoModel.highPrice24H),
                      style: const TextStyle(),
                    ),
                    const TextSpan(
                      text: r'$',
                      style: TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          LinearPercentIndicator(
            lineHeight: 20,
            animation: false,
            center: Text(
              r"$" + GlobalHelper.formatDecimalPattern(cryptoModel.price),
              style: const TextStyle(
                color: Colors.black87,
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
            ),
            percent: pricePercent,
            progressColor: _colorFromPercent(pricePercent),
            backgroundColor: const Color(0xFFDFDFDF),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Text(
                'Market Dominance',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
              Spacer(),
              InfoTooltip(
                  message:
                      "Dominance measures the coin's market cap relative to the overall crypto market\nMarket cap - total value of all the coins that have been mined")
            ],
          ),
          const SizedBox(height: 5),
          LinearPercentIndicator(
            lineHeight: 20,
            animation: false,
            center: Text(
              cryptoModel.marketDominancePercentage.toInt().toString() + "%",
              style: const TextStyle(
                color: Colors.black87,
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
            ),
            percent: cryptoModel.marketDominancePercentage / 100,
            progressColor:
                _colorFromPercent(cryptoModel.marketDominancePercentage / 100),
            backgroundColor: const Color(0xFFDFDFDF),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
