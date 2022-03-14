import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoviz_assign/models/cryptocurrency_model.dart';
import 'package:infoviz_assign/global_helper.dart';
import 'package:infoviz_assign/global_widgets/info_tooltip.dart';
import 'package:infoviz_assign/screens/home_page/bloc/crypto_data_bloc.dart';
import 'package:infoviz_assign/screens/home_page/bloc/cubit/cartesian_graph_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'custom_cartesian_chart.dart';

class SemanticsCartesianChart extends StatefulWidget {
  const SemanticsCartesianChart({
    Key? key,
    required TrackballBehavior trackballBehaviorSemantics,
    required ZoomPanBehavior zoomPanBehavior,
    required this.bitcoins,
    required this.ethereums,
    required this.solanas,
  })  : _trackballBehaviorSemantics = trackballBehaviorSemantics,
        _zoomPanBehavior = zoomPanBehavior,
        super(key: key);

  final TrackballBehavior _trackballBehaviorSemantics;
  final ZoomPanBehavior _zoomPanBehavior;
  final List<CryptocurrencyModel> bitcoins;
  final List<CryptocurrencyModel> ethereums;
  final List<CryptocurrencyModel> solanas;

  @override
  State<SemanticsCartesianChart> createState() =>
      _SemanticsCartesianChartState();
}

class _SemanticsCartesianChartState extends State<SemanticsCartesianChart> {
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
      coinsSelected: [false, false, false],
    );

    return BlocProvider(
      create: (_) => _cartesianGraphCubit,
      child: BlocBuilder<CartesianGraphCubit, CartesianGraphState>(
        builder: (context, state) {
          if (state is! CartesianGraphChanged) {
            print(
                "State is not CartesianGraphChanged in prices_cartesian_chart.dart");
            return const SizedBox();
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
                              "Average positivity or negativivity of tweets mentioning a cryptocurrency name, where\n 1: super positive\n 0: neutral\n-1: super negative"),
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
                                    }); // setstate of stateful builder right above to rebuild checkbox
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
                          trackballBehavior: widget._trackballBehaviorSemantics,
                          zoomPanBehavior: widget._zoomPanBehavior,
                          type: CartesianGraphType.semantics,
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
