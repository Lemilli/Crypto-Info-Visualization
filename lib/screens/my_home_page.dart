import 'package:flutter/material.dart';
import 'package:infoviz_assign/variables.dart';
import 'package:infoviz_assign/widgets/semantics_radial_bar.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/cryptocurrency_model.dart';
import '../network/api_handler.dart';
import '../widgets/custom_cartesian_chart.dart';
import '../widgets/trackball_pop_up.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TrackballBehavior _trackballBehaviorPrice,
      _trackballBehaviorTweetCount,
      _trackballBehaviorSemantics;
  late ZoomPanBehavior _zoomPanBehavior;
  late final apiHanlder = APIHanlder();
  late final List<CryptocurrencyModel> bitcoins, ethereums, solanas;
  List<CryptocurrencyModel> latestSemantics = List.empty(growable: true);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _trackballBehaviorPrice = TrackballBehavior(
      // Enables the trackball
      enable: true,
      tooltipSettings: const InteractiveTooltip(enable: true),
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
      zoomMode: ZoomMode.xy,
    );

    _assignCryptoData();
  }

  void _assignCryptoData() async {
    // Network stuff
    bitcoins = await apiHanlder.getCryptoData('btc');
    ethereums = await apiHanlder.getCryptoData('eth');
    solanas = await apiHanlder.getCryptoData('sol');

    latestSemantics.add(bitcoins.last);
    latestSemantics.add(ethereums.last);
    latestSemantics.add(solanas.last);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 600,
                  width: double.infinity,
                  child: Center(child: CircularProgressIndicator()))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        'The Impact of Twitter on Cryptocurrency Pricing Movement',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Twitter has been the most influential social media platform regarding the world of cryptocurrency. Millions of tweets are posted on every hour, including the developers, constitutions, influencers and retail investors. With the abundance of available tweets, we ouoght to find out whether Twitter has a role in cryptocurrency’s pricing movement in real time.',
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
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Top Cryptocurrency',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Three major cryptocurrecies are selected and projected in line graph in conjunction with the amount of Tweets.',
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
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/btc_logo.png'),
                              const SizedBox(width: 10),
                              const Text(
                                'Prices',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomCartesianChart(
                            trackballBehavior: _trackballBehaviorPrice,
                            zoomPanBehavior: _zoomPanBehavior,
                            bitcoins: bitcoins,
                            ethereums: ethereums,
                            solanas: solanas,
                            type: CartesianGraphType.price,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDF8),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.fromLTRB(28, 14, 28, 14),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/ethereum_logo.png'),
                              const SizedBox(width: 10),
                              const Text(
                                'Tweet Count',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomCartesianChart(
                            trackballBehavior: _trackballBehaviorTweetCount,
                            zoomPanBehavior: _zoomPanBehavior,
                            bitcoins: bitcoins,
                            ethereums: ethereums,
                            solanas: solanas,
                            type: CartesianGraphType.tweetCount,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDF8),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.fromLTRB(28, 14, 28, 14),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/solana_logo.png'),
                              const SizedBox(width: 10),
                              const Text(
                                'Semantics',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomCartesianChart(
                            trackballBehavior: _trackballBehaviorSemantics,
                            zoomPanBehavior: _zoomPanBehavior,
                            bitcoins: bitcoins,
                            ethereums: ethereums,
                            solanas: solanas,
                            type: CartesianGraphType.semantics,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Semantics',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Below determines the percentage of positive, negative, and neutral tweets for each cryptocurrency.',
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
                  ],
                ),
        ),
      ),
    );
  }
}
