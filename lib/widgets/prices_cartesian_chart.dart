import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoviz_assign/models/cryptocurrency_model.dart';
import 'package:infoviz_assign/screens/home_page/bloc/cubit/scroll_cubit.dart';
import 'package:infoviz_assign/global_helper.dart';
import 'package:infoviz_assign/widgets/custom_cartesian_chart.dart';
import 'package:infoviz_assign/global_widgets/info_tooltip.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PricesCartesianChart extends StatefulWidget {
  const PricesCartesianChart({
    Key? key,
    required TrackballBehavior trackballBehaviorPrice,
    required ZoomPanBehavior zoomPanBehavior,
    required this.bitcoins,
    required this.ethereums,
    required this.solanas,
  })  : _trackballBehaviorPrice = trackballBehaviorPrice,
        _zoomPanBehavior = zoomPanBehavior,
        super(key: key);

  final TrackballBehavior _trackballBehaviorPrice;
  final ZoomPanBehavior _zoomPanBehavior;
  final List<CryptocurrencyModel> bitcoins;
  final List<CryptocurrencyModel> ethereums;
  final List<CryptocurrencyModel> solanas;

  @override
  State<PricesCartesianChart> createState() => _PricesCartesianChartState();
}

class _PricesCartesianChartState extends State<PricesCartesianChart> {
  bool isFoldPrices = false;
  bool isVisibleBTCPrice = true;
  bool isVisibleETHPrice = false;
  bool isVisibleSOLPrice = false;

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isFoldPrices ? const Color(0xFFD6D6D6) : const Color(0xFFFFFDF8),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.fromLTRB(28, 14, 28, 14),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      'Coin price in USD over time\nUpdated every 15 minutes'),
              const SizedBox(width: 10),
              ChoiceChip(
                backgroundColor: Colors.transparent,
                selectedColor: Colors.black54,
                label: Text(
                  GlobalHelper.cryptoNames[0],
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
                backgroundColor: Colors.transparent,
                selectedColor: Colors.black54,
                label: Text(
                  GlobalHelper.cryptoNames[1],
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
                backgroundColor: Colors.transparent,
                selectedColor: Colors.black54,
                label: Text(
                  GlobalHelper.cryptoNames[2],
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
                  isFoldPrices = !isFoldPrices;
                }),
                child: isFoldPrices
                    ? const Icon(Icons.arrow_drop_up_outlined)
                    : const Icon(Icons.arrow_drop_down_outlined),
              )
            ],
          ),
          isFoldPrices ? const SizedBox() : const SizedBox(height: 10),
          isFoldPrices
              ? const SizedBox()
              : MouseRegion(
                  onEnter: (event) =>
                      BlocProvider.of<ScrollCubit>(context).disable(),
                  onExit: (event) =>
                      BlocProvider.of<ScrollCubit>(context).enable(),
                  child: CustomCartesianChart(
                    trackballBehavior: widget._trackballBehaviorPrice,
                    zoomPanBehavior: widget._zoomPanBehavior,
                    bitcoins: widget.bitcoins,
                    ethereums: widget.ethereums,
                    solanas: widget.solanas,
                    type: CartesianGraphType.price,
                    isVisibleBTCPrice: isVisibleBTCPrice,
                    isVisibleETHPrice: isVisibleETHPrice,
                    isVisibleSOLPrice: isVisibleSOLPrice,
                  ),
                ),
        ],
      ),
    );
  }
}
