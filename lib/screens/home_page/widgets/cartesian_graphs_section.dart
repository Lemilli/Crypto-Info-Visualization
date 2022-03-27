import 'package:flutter/material.dart';
import 'package:infoviz_assign/screens/home_page/widgets/cartesian_chart_wrapper.dart';

import 'custom_cartesian_chart.dart';

class CartesianGraphsSection extends StatelessWidget {
  const CartesianGraphsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: const [
              Text(
                'Top Cryptocurrency',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Three major cryptocurrecies are selected and projected in line graph in conjunction with the prices, amount of Tweets and Tweets semantics.',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 14),
        const CartesianChartWrapper(
          graphType: CartesianGraphType.price,
          title: 'Price',
          icon: Icons.price_change_outlined,
          tooltipHint: 'Coin price in USD over time\nUpdated every 15 minutes',
        ),
        const SizedBox(height: 30),
        const CartesianChartWrapper(
          graphType: CartesianGraphType.tweetCount,
          title: 'Tweet Count',
          icon: Icons.format_list_numbered_rounded,
          tooltipHint:
              "Number of tweets that contain a cryptocurrency name\nUpdated every 15 minutes",
        ),
        const SizedBox(height: 30),
        const CartesianChartWrapper(
          graphType: CartesianGraphType.semantics,
          title: 'Semantics',
          icon: Icons.speaker_notes_outlined,
          tooltipHint:
              "Average positivity or negativivity of tweets mentioning a cryptocurrency name, where\n 100: super positive\n 0: neutral\n-100: super negative",
        ),
      ],
    );
  }
}
