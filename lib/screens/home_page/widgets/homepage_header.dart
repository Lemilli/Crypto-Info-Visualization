import 'package:flutter/material.dart';

class HomepageHeader extends StatelessWidget {
  const HomepageHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'The Impact of Twitter on Cryptocurrency Pricing Movement',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "Twitter's the most influential social media in the cryptocurrency world. Thousands of tweets are posted every day by people interested in cryptocurrency. This tool will help you analyze those tweets and make better predictions based on people's mood towards specific coins.",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xffcacaca),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
