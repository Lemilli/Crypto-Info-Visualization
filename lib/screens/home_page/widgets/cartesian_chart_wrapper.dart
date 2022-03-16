import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoviz_assign/global_helper.dart';
import 'package:infoviz_assign/global_widgets/info_tooltip.dart';
import 'package:infoviz_assign/screens/home_page/bloc/crypto_data_bloc.dart';
import 'package:infoviz_assign/screens/home_page/bloc/cubit/cartesian_graph_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'custom_cartesian_chart.dart';

class CartesianChartWrapper extends StatelessWidget {
  const CartesianChartWrapper({
    Key? key,
    required this.graphType,
    required this.title,
    required this.tooltipHint,
    required this.icon,
  }) : super(key: key);

  final CartesianGraphType graphType;
  final String title;
  final String tooltipHint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    // Get original data from state
    final dataState =
        BlocProvider.of<CryptoDataBloc>(context).state as CryptoDataLoaded;
    final _cartesianGraphCubit = CartesianGraphCubit(
      bitcoins: dataState.bitcoins,
      ethereums: dataState.ethereums,
      solanas: dataState.solanas,
      latestSemantics: dataState.latestSemantics,
      coinsSelected: [false, false, true],
    );

    final TrackballBehavior trackballBehavior;
    switch (graphType) {
      case CartesianGraphType.price:
        trackballBehavior = dataState.trackballBehaviorPrice;
        break;
      case CartesianGraphType.tweetCount:
        trackballBehavior = dataState.trackballBehaviorTweetCount;
        break;
      case CartesianGraphType.semantics:
        trackballBehavior = dataState.trackballBehaviorSemantics;
        break;
    }

    return BlocProvider(
      create: (_) => _cartesianGraphCubit,
      child: BlocBuilder<CartesianGraphCubit, CartesianGraphState>(
        builder: (context, state) {
          if (state is! CartesianGraphChanged) {
            return const Text(
                'Error. State is not CartesianGraphChanged, but it should be.');
          } else {
            return Container(
              decoration: BoxDecoration(
                color: state.isFolded
                    ? const Color(0xFFD6D6D6)
                    : const Color(0xFFFFFDF8),
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.fromLTRB(28, 14, 28, 14),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Icon(
                        icon,
                        size: 35,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      InfoTooltip(message: tooltipHint),
                      const SizedBox(width: 20),
                      Container(
                        width: 140,
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 0.5),
                        ),
                        child: DropdownButton<String>(
                          value: null,
                          isExpanded: true,
                          underline: const SizedBox(),
                          focusColor: Colors.transparent,
                          items: List.generate(
                            state.coinsSelected.length,
                            (i) => DropdownMenuItem(
                              value: i.toString(),
                              enabled: false,
                              child: StatefulBuilder(
                                builder: (context, setState) =>
                                    CheckboxListTile(
                                  value: state.coinsSelected[i],
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(GlobalHelper.cryptoNames[i]),
                                  onChanged: (value) {
                                    _cartesianGraphCubit.updateCoinsVisibility(
                                      i,
                                      !state.coinsSelected[i],
                                    );

                                    setState(() {
                                      state.coinsSelected[i] =
                                          !state.coinsSelected[i];
                                    }); // local setstate of stateful builder parent right above to rebuild checkbox
                                  },
                                ),
                              ),
                            ),
                          ),
                          onChanged: (_) {},
                          hint: const Text("Select Coins"),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          state.isFolded
                              ? _cartesianGraphCubit.unfold()
                              : _cartesianGraphCubit.fold();
                        },
                        child: state.isFolded
                            ? const Icon(Icons.arrow_drop_up_outlined)
                            : const Icon(Icons.arrow_drop_down_outlined),
                      )
                    ],
                  ),
                  state.isFolded
                      ? const SizedBox()
                      : const SizedBox(height: 10),
                  state.isFolded
                      ? const SizedBox()
                      : CustomCartesianChart(
                          trackballBehavior: trackballBehavior,
                          zoomPanBehavior: dataState.zoomPanBehavior,
                          type: graphType,
                          isVisibleBTCPrice: state.coinsSelected[0],
                          isVisibleETHPrice: state.coinsSelected[1],
                          isVisibleSOLPrice: state.coinsSelected[2],
                        ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
