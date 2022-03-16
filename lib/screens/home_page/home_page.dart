import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoviz_assign/global_widgets/top_navigation_button.dart';
import 'package:infoviz_assign/screens/about_page/about_page.dart';
import 'package:infoviz_assign/screens/home_page/bloc/crypto_data_bloc.dart';
import 'package:infoviz_assign/global_helper.dart';
import 'package:infoviz_assign/global_widgets/info_tooltip.dart';
import 'package:infoviz_assign/screens/home_page/widgets/custom_cartesian_chart.dart';
import 'package:infoviz_assign/screens/home_page/widgets/price_stats_widget.dart';
import 'package:infoviz_assign/screens/home_page/widgets/semantics_radial_bar.dart';

import 'widgets/cartesian_chart_wrapper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get data from backend
    final _cryptoBloc = CryptoDataBloc();
    _cryptoBloc.add(GetCryptoData());
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _cryptoBloc),
        ],
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            decoration: const BoxDecoration(
              color: Color(0xFF000D19),
            ),
            child: BlocBuilder<CryptoDataBloc, CryptoDataState>(
              builder: (context, state) {
                if (state is CryptoDataLoading || state is CryptoDataInitial) {
                  return SizedBox(
                    height: height,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (state is CryptoDataLoaded) {
                  return const LoadedUI();
                } else if (state is CryptoDataError) {
                  return SizedBox(
                    height: height,
                    child: const Center(
                      child: Text(
                        "Error. Try again later.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: height,
                    child: const Center(
                      child: Text(
                        "No corresponding BLOC state",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LoadedUI extends StatelessWidget {
  const LoadedUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(
      BlocProvider.of<CryptoDataBloc>(context).state is CryptoDataLoaded,
      'state must be CryptoDataLoaded according to if statement from parent',
    );

    final dataState =
        BlocProvider.of<CryptoDataBloc>(context).state as CryptoDataLoaded;

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(height: 30),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          TopNavigationButton(
            text: 'Home',
            onPressed: (() => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                )),
          ),
          const Spacer(),
          TopNavigationButton(
            text: 'About',
            onPressed: (() => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                )),
          ),
        ],
      ),
      const SizedBox(height: 20),
      const Text(
        'The Impact of Twitter on Cryptocurrency Pricing Movement',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 5),
      const Padding(
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
      const SizedBox(height: 40),
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
            "Average positivity or negativivity of tweets mentioning a cryptocurrency name, where\n 1: super positive\n 0: neutral\n-1: super negative",
      ),
      const SizedBox(height: 25),
      Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            const Text(
              'Semantics',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                height: 1.2,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 8),
            InfoTooltip(
              message: DateTime.now()
                      .difference(dataState.latestSemantics.first.datetime)
                      .inMinutes
                      .toString() +
                  ' minutes ago',
              makeWhite: true,
            ),
          ],
        ),
      ),
      const Align(
        alignment: Alignment.topLeft,
        child: Text(
          'The percentage of positive, negative, and neutral tweets for each cryptocurrency every 15 minutes.',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 12,
          ),
        ),
      ),
      const SizedBox(height: 14),
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFFDF8),
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.fromLTRB(28, 14, 28, 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SemanticsRadialBar(
              latestSemantics: dataState.latestSemantics,
              semanticsType: SemanticsType.positive,
            ),
            SemanticsRadialBar(
              latestSemantics: dataState.latestSemantics,
              semanticsType: SemanticsType.negative,
            ),
            SemanticsRadialBar(
              latestSemantics: dataState.latestSemantics,
              semanticsType: SemanticsType.neutral,
            ),
          ],
        ),
      ),
      const SizedBox(height: 30),
      Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            const Text(
              'Pricing Statistics',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 8),
            InfoTooltip(
              message: DateTime.now()
                      .difference(dataState.latestSemantics.first.datetime)
                      .inMinutes
                      .toString() +
                  ' minutes ago',
              makeWhite: true,
            ),
          ],
        ),
      ),
      const Align(
        alignment: Alignment.topLeft,
        child: Text(
          'Cryptocurrency-related statistics',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 12,
          ),
        ),
      ),
      const SizedBox(height: 10),
      LayoutBuilder(
        builder: (context, constraints) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PriceStatsWidget(
              width: constraints.maxWidth,
              cryptoModel: dataState.latestSemantics[0],
              imagePath: GlobalHelper.cryptoImages[0],
              cryptoName: GlobalHelper.cryptoNames[0],
            ),
            PriceStatsWidget(
              width: constraints.maxWidth,
              cryptoModel: dataState.latestSemantics[1],
              imagePath: GlobalHelper.cryptoImages[1],
              cryptoName: GlobalHelper.cryptoNames[1],
            ),
            PriceStatsWidget(
              width: constraints.maxWidth,
              cryptoModel: dataState.latestSemantics[2],
              imagePath: GlobalHelper.cryptoImages[2],
              cryptoName: GlobalHelper.cryptoNames[2],
            ),
          ],
        ),
      ),
      const SizedBox(height: 80),
      const Align(
        alignment: Alignment.topRight,
        child: Text(
          'Powered by CoinGecko API and Twitter API',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(height: 10),
    ]);
  }
}
