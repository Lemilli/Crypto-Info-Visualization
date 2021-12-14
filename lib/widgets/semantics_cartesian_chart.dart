import 'package:flutter/material.dart';
import 'package:infoviz_assign/models/cryptocurrency_model.dart';
import 'package:infoviz_assign/variables.dart';
import 'package:infoviz_assign/widgets/custom_cartesian_chart.dart';
import 'package:infoviz_assign/widgets/info_tooltip.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  bool isFoldSemantics = false;
  bool isVisibleBTCPrice = true;
  bool isVisibleETHPrice = true;
  bool isVisibleSOLPrice = true;

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            isFoldSemantics ? const Color(0xFFD6D6D6) : const Color(0xFFFFFDF8),
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
              const SizedBox(width: 10),
              ChoiceChip(
                selectedColor: Colors.black54,
                backgroundColor: Colors.transparent,
                label: Text(
                  ConstVariables.cryptoNames[0],
                  style: TextStyle(
                    color: isVisibleBTCPrice ? Colors.white : Colors.black,
                  ),
                ),
                selected: isVisibleBTCPrice,
                onSelected: (value) {
                  isVisibleBTCPrice = !isVisibleBTCPrice;
                  refresh();
                },
              ),
              const SizedBox(width: 5),
              ChoiceChip(
                selectedColor: Colors.black54,
                backgroundColor: Colors.transparent,
                label: Text(
                  ConstVariables.cryptoNames[1],
                  style: TextStyle(
                    color: isVisibleETHPrice ? Colors.white : Colors.black,
                  ),
                ),
                selected: isVisibleETHPrice,
                onSelected: (value) {
                  isVisibleETHPrice = !isVisibleETHPrice;
                  refresh();
                },
              ),
              const SizedBox(width: 5),
              ChoiceChip(
                selectedColor: Colors.black54,
                backgroundColor: Colors.transparent,
                label: Text(
                  ConstVariables.cryptoNames[2],
                  style: TextStyle(
                    color: isVisibleSOLPrice ? Colors.white : Colors.black,
                  ),
                ),
                selected: isVisibleSOLPrice,
                onSelected: (value) {
                  isVisibleSOLPrice = !isVisibleSOLPrice;
                  refresh();
                },
              ),
              const Spacer(),
              InkWell(
                onTap: () => setState(() {
                  isFoldSemantics = !isFoldSemantics;
                }),
                child: isFoldSemantics
                    ? const Icon(Icons.arrow_drop_up_outlined)
                    : const Icon(Icons.arrow_drop_down_outlined),
              )
            ],
          ),
          isFoldSemantics ? const SizedBox() : const SizedBox(height: 10),
          isFoldSemantics
              ? const SizedBox()
              : CustomCartesianChart(
                  trackballBehavior: widget._trackballBehaviorSemantics,
                  zoomPanBehavior: widget._zoomPanBehavior,
                  bitcoins: widget.bitcoins,
                  ethereums: widget.ethereums,
                  solanas: widget.solanas,
                  type: CartesianGraphType.semantics,
                  isVisibleBTCPrice: isVisibleBTCPrice,
                  isVisibleETHPrice: isVisibleETHPrice,
                  isVisibleSOLPrice: isVisibleSOLPrice,
                ),
        ],
      ),
    );
  }
}
