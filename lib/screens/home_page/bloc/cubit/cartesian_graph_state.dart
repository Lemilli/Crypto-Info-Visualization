part of 'cartesian_graph_cubit.dart';

abstract class CartesianGraphState extends Equatable {
  const CartesianGraphState();

  @override
  List<Object> get props => [];
}

class CartesianGraphChanged extends CartesianGraphState {
  final List<CryptocurrencyModel> bitcoins;
  final List<CryptocurrencyModel> ethereums;
  final List<CryptocurrencyModel> solanas;
  final List<CryptocurrencyModel> latestSemantics;
  final DateTimeAxis dateTimeAxis;
  final List<bool> coinsSelected; //  Order: BTC, ETH, SOL
  final bool isFolded;
  final String? filterByDateText;
  double zoomFactor;
  final zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true,
    enablePanning: true,
    enableDoubleTapZooming: true,
    zoomMode: ZoomMode.x,
    maximumZoomLevel: 0.8,
  );

  CartesianGraphChanged({
    required this.bitcoins,
    required this.ethereums,
    required this.solanas,
    required this.latestSemantics,
    required this.dateTimeAxis,
    this.coinsSelected = const [true, true, true],
    this.isFolded = false,
    this.filterByDateText, // null by default
    this.zoomFactor = 1.0,
  });

  CartesianGraphChanged copyWith({
    List<CryptocurrencyModel>? bitcoins,
    List<CryptocurrencyModel>? ethereums,
    List<CryptocurrencyModel>? solanas,
    List<CryptocurrencyModel>? latestSemantics,
    DateTimeAxis? dateTimeAxis,
    List<bool>? coinsSelected,
    bool? isFolded,
    String? filterByDateText,
    double? zoomFactor,
  }) =>
      CartesianGraphChanged(
        bitcoins: bitcoins ?? this.bitcoins,
        ethereums: ethereums ?? this.ethereums,
        solanas: solanas ?? this.solanas,
        latestSemantics: latestSemantics ?? this.latestSemantics,
        dateTimeAxis: dateTimeAxis ?? this.dateTimeAxis,
        coinsSelected: coinsSelected ?? this.coinsSelected,
        isFolded: isFolded ?? this.isFolded,
        filterByDateText: filterByDateText ?? this.filterByDateText,
        zoomFactor: zoomFactor ?? this.zoomFactor,
      );

  @override
  List<Object> get props => [
        bitcoins,
        ethereums,
        solanas,
        latestSemantics,
        coinsSelected,
        isFolded,
      ];
}
