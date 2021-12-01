import 'package:flutter/material.dart';
import 'package:infoviz_assign/variables.dart';
import 'package:infoviz_assign/widgets/info_tooltip.dart';
import 'package:infoviz_assign/widgets/price_stats_widget.dart';
import 'package:infoviz_assign/widgets/semantics_radial_bar.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        //physics: NeverScrollableScrollPhysics(),
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
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Icon(
                                Icons.price_change_outlined,
                                size: 35,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Prices',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const InfoTooltip(
                                  message:
                                      'Coin price in USD over time\nUpdated every minute'),
                              const SizedBox(width: 10),
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
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Icon(
                                Icons.format_list_numbered_rounded,
                                size: 35,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Tweet Count',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const InfoTooltip(
                                  message:
                                      "Number of tweets that contain a cryptocurrency name\nUpdated every minute"),
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
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Icon(
                                Icons.speaker_notes_outlined,
                                size: 35,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Semantics',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const InfoTooltip(
                                  message:
                                      "Average tweets positivity or negativivity of tweets mentioning crypto a cryptocurrency name, where\n 1: super positive\n 0: neutral\n-1: super negative"),
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
                    const SizedBox(height: 30),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Pricing Statistics',
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
                        'Below depicts three major pricing statistics',
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
                          imagePath: 'assets/images/btc_logo.png',
                          cryptoName: ConstVariables.cryptoNames[0],
                        ),
                        PriceStatsWidget(
                          width: width,
                          cryptoModel: latestSemantics[1],
                          imagePath: 'assets/images/ethereum_logo.png',
                          cryptoName: ConstVariables.cryptoNames[1],
                        ),
                        PriceStatsWidget(
                          width: width,
                          cryptoModel: latestSemantics[2],
                          imagePath: 'assets/images/solana_logo.png',
                          cryptoName: ConstVariables.cryptoNames[2],
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
                  ],
                ),
        ),
      ),
    );
  }
}


// class HoverableWidget extends StatefulWidget {
//   const HoverableWidget({
//     Key? key,
//     required this.text,
//   }) : super(key: key);

//   final String text;

//   @override
//   State<HoverableWidget> createState() => _HoverableWidgetState();
// }

// class _HoverableWidgetState extends State<HoverableWidget> {
//   bool isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (event) => print('enter'),
//       onExit: (event) => print('exit'),
//       child: SvgPicture.asset(
//         'assets/images/info_icon.svg',
//         width: 20,
//         height: 20,
//       ),
//     );
//   }
// }
