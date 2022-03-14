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
  final List<bool> coinsSelected; //  Order: BTC, ETH, SOL
  final bool isFolded;

  const CartesianGraphChanged({
    required this.bitcoins,
    required this.ethereums,
    required this.solanas,
    required this.latestSemantics,
    this.coinsSelected = const [true, true, true],
    this.isFolded = false,
  });

  CartesianGraphChanged copyWith({
    List<CryptocurrencyModel>? bitcoins,
    List<CryptocurrencyModel>? ethereums,
    List<CryptocurrencyModel>? solanas,
    List<CryptocurrencyModel>? latestSemantics,
    List<bool>? coinsSelected,
    bool? isFolded,
  }) =>
      CartesianGraphChanged(
        bitcoins: bitcoins ?? this.bitcoins,
        ethereums: ethereums ?? this.ethereums,
        solanas: solanas ?? this.solanas,
        latestSemantics: latestSemantics ?? this.latestSemantics,
        coinsSelected: coinsSelected ?? this.coinsSelected,
        isFolded: isFolded ?? this.isFolded,
      );

  @override
  List<Object> get props =>
      [bitcoins, ethereums, solanas, latestSemantics, coinsSelected, isFolded];
}
