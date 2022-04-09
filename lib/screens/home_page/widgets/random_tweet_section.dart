import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoviz_assign/global_helper.dart';
import 'package:infoviz_assign/global_widgets/info_tooltip.dart';
import 'package:infoviz_assign/screens/home_page/bloc/crypto_data_bloc.dart';

class RandomTweetSection extends StatelessWidget {
  const RandomTweetSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataBloc = BlocProvider.of<CryptoDataBloc>(context);
    final dataState = dataBloc.state as CryptoDataLoaded;

    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                const Text(
                  'Random Tweet Semantics',
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
              'Semantics evaluation of random tweets about cryptocurrencies every 15 minutes',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: GlobalHelper.cryptoNames
                  .map(
                    (cryptoName) => SizedBox(
                      width: constraints.maxWidth / 3.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            GlobalHelper.getImagePathFromName(cryptoName),
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            cryptoName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList()),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              dataState.randomTweetBTC,
              dataState.randomTweetETH,
              dataState.randomTweetSOL,
            ]
                .map(
                  (e) => Container(
                    width: constraints.maxWidth / 3.2,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFDF8),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: const EdgeInsets.fromLTRB(28, 14, 28, 14),
                    child: e == null
                        ? const Text(
                            'Error. Try again later.',
                            style: TextStyle(color: Colors.red),
                          )
                        : Column(
                            children: [
                              Text(
                                e.tweet,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              const SizedBox(height: 8),
                              RichText(
                                text: TextSpan(children: [
                                  const TextSpan(
                                    text: 'Evaluation: ',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: e.eval.toString() +
                                        '% (${GlobalHelper.getTextFromSemantics(e.eval)})',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: GlobalHelper.getColorFromSemantics(
                                          e.eval),
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
