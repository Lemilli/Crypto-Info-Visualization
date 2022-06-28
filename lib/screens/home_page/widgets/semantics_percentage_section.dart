import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoviz_assign/global_widgets/info_tooltip.dart';
import 'package:infoviz_assign/screens/home_page/bloc/crypto_data_bloc.dart';
import 'package:infoviz_assign/screens/home_page/widgets/semantics_radial_bar.dart';

class SemanticsPercentageSection extends StatelessWidget {
  const SemanticsPercentageSection({Key? key}) : super(key: key);

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
                'Semantics Percentage',
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
      ],
    );
  }
}
