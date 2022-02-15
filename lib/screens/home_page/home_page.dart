import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoviz_assign/global_widgets/top_navigation_button.dart';
import 'package:infoviz_assign/screens/about_page/about_page.dart';
import 'package:infoviz_assign/screens/home_page/bloc/crypto_data_bloc.dart';
import 'package:infoviz_assign/screens/home_page/bloc/cubit/scroll_cubit.dart';
import 'package:infoviz_assign/variables.dart';
import 'package:infoviz_assign/global_widgets/info_tooltip.dart';
import 'package:infoviz_assign/widgets/price_stats_widget.dart';
import 'package:infoviz_assign/widgets/prices_cartesian_chart.dart';
import 'package:infoviz_assign/widgets/semantics_cartesian_chart.dart';
import 'package:infoviz_assign/widgets/semantics_radial_bar.dart';
import 'package:infoviz_assign/widgets/tweet_count_cartesian.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/cryptocurrency_model.dart';
import '../../widgets/custom_cartesian_chart.dart';
import '../../widgets/trackball_pop_up.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TrackballBehavior _trackballBehaviorPrice,
      _trackballBehaviorTweetCount,
      _trackballBehaviorSemantics;
  late ZoomPanBehavior _zoomPanBehavior;
  final _cryptoBloc = CryptoDataBloc();
  final _scrollCubit = ScrollCubit();

  @override
  void initState() {
    super.initState();

    _setupInteractivity();
    // get data from backend
    _cryptoBloc.add(GetCryptoData());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _cryptoBloc),
          BlocProvider(create: (context) => _scrollCubit),
        ],
        // Disable scroll of the page whenever user is hovering over a zoomable chart/graph
        // So that user can scroll the chart to zoom in
        child: BlocListener<ScrollCubit, ScrollState>(
          listener: (context, state) => setState(() {}),
          child: SingleChildScrollView(
            physics: _scrollCubit.state.scrollPhysics,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              decoration: const BoxDecoration(
                color: Color(0xFF000D19),
              ),
              child: BlocBuilder<CryptoDataBloc, CryptoDataState>(
                builder: (context, state) {
                  if (state is CryptoDataLoading ||
                      state is CryptoDataInitial) {
                    return SizedBox(
                      height: height,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is CryptoDataLoaded) {
                    return _buildLoaded(
                      context,
                      state.bitcoins,
                      state.ethereums,
                      state.solanas,
                      state.latestSemantics,
                      width,
                    );
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
      ),
    );
  }

  Widget _buildLoaded(
    BuildContext context,
    List<CryptocurrencyModel> bitcoins,
    List<CryptocurrencyModel> ethereums,
    List<CryptocurrencyModel> solanas,
    List<CryptocurrencyModel> latestSemantics,
    double width,
  ) {
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
      PricesCartesianChart(
          trackballBehaviorPrice: _trackballBehaviorPrice,
          zoomPanBehavior: _zoomPanBehavior,
          bitcoins: bitcoins,
          ethereums: ethereums,
          solanas: solanas),
      const SizedBox(height: 30),
      TweetCountCartesian(
          trackballBehaviorTweetCount: _trackballBehaviorTweetCount,
          zoomPanBehavior: _zoomPanBehavior,
          bitcoins: bitcoins,
          ethereums: ethereums,
          solanas: solanas),
      const SizedBox(height: 30),
      SemanticsCartesianChart(
          trackballBehaviorSemantics: _trackballBehaviorSemantics,
          zoomPanBehavior: _zoomPanBehavior,
          bitcoins: bitcoins,
          ethereums: ethereums,
          solanas: solanas),
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
                      .difference(latestSemantics.first.datetime)
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
              latestSemantics: latestSemantics,
              semanticsType: SemanticsType.positive,
            ),
            SemanticsRadialBar(
              latestSemantics: latestSemantics,
              semanticsType: SemanticsType.negative,
            ),
            SemanticsRadialBar(
              latestSemantics: latestSemantics,
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
                      .difference(latestSemantics.first.datetime)
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PriceStatsWidget(
            width: width,
            cryptoModel: latestSemantics[0],
            imagePath: GlobalHelper.cryptoImages[0],
            cryptoName: GlobalHelper.cryptoNames[0],
          ),
          PriceStatsWidget(
            width: width,
            cryptoModel: latestSemantics[1],
            imagePath: GlobalHelper.cryptoImages[1],
            cryptoName: GlobalHelper.cryptoNames[1],
          ),
          PriceStatsWidget(
            width: width,
            cryptoModel: latestSemantics[2],
            imagePath: GlobalHelper.cryptoImages[2],
            cryptoName: GlobalHelper.cryptoNames[2],
          ),
        ],
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

  void _setupInteractivity() {
    _trackballBehaviorPrice = TrackballBehavior(
      // Enables the trackball
      enable: true,
      tooltipSettings: const InteractiveTooltip(enable: true),
      activationMode: ActivationMode.singleTap,
      builder: (context, trackballDetails) => trackballDetails.point == null
          ? const SizedBox()
          : TrackballPopUpWidget(
              trackballDetails: trackballDetails,
              type: CartesianGraphType.price,
            ),
    );

    _trackballBehaviorTweetCount = TrackballBehavior(
      // Enables the trackball
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(enable: true),
      builder: (context, trackballDetails) => trackballDetails.point == null
          ? const SizedBox()
          : TrackballPopUpWidget(
              trackballDetails: trackballDetails,
              type: CartesianGraphType.tweetCount,
            ),
    );

    _trackballBehaviorSemantics = TrackballBehavior(
      // Enables the trackball
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(enable: true),
      builder: (context, trackballDetails) => trackballDetails.point == null
          ? const SizedBox()
          : TrackballPopUpWidget(
              trackballDetails: trackballDetails,
              type: CartesianGraphType.semantics,
            ),
    );

    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      enableMouseWheelZooming: true,
      zoomMode: ZoomMode.x,
    );
  }
}
