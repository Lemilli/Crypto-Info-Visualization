import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoviz_assign/global_helper.dart';
import 'package:infoviz_assign/global_widgets/info_tooltip.dart';
import 'package:infoviz_assign/screens/home_page/bloc/crypto_data_bloc.dart';
import 'package:infoviz_assign/screens/home_page/widgets/price_stats_widget.dart';

class PricingStatsSection extends StatelessWidget {
  const PricingStatsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataState =
        BlocProvider.of<CryptoDataBloc>(context).state as CryptoDataLoaded;

    return Column(
      children: [
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
                message: 'Updated ' +
                    DateTime.now()
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
      ],
    );
  }
}
