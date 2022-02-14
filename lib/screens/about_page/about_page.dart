import 'package:flutter/material.dart';
import 'package:infoviz_assign/global_widgets/info_tooltip.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(60, 50, 60, 0),
        height: height,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF000D19),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'About Page',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Data Resources',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SelectableText(
              'Tweets data is from official Twitter API.\n'
              'Cryptocurrencies data comes from CoinGecko.\n',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Calculation Methods',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SelectableText(
              'Tweet count includes tweets that mention cryptocurrency full or short name (e.g., bitcoin or btc). Replies to other tweets do not count, but retweets do.\n'
              'Semantics are a result of lexicon and rule-based analysis provided by VADER analysis tool that is specifically attuned to sentiments expressed in social media',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
            Row(
              children: const [
                SelectableText(
                  'More information is available when you hover over items like this:  ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
                InfoTooltip(
                  makeWhite: true,
                  message: "Try it in the home page",
                )
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Get in touch',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Row(
              children: const [
                Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Email: ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
                SelectableText(
                  'test@gmail.com',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
