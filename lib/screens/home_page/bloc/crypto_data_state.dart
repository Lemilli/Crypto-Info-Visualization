part of 'crypto_data_bloc.dart';

abstract class CryptoDataState extends Equatable {
  const CryptoDataState();

  @override
  List<Object?> get props => [];
}

class CryptoDataInitial extends CryptoDataState {}

class CryptoDataLoading extends CryptoDataState {}

class CryptoDataError extends CryptoDataState {
  final String? message;

  const CryptoDataError(this.message);
}

class CryptoDataLoaded extends CryptoDataState {
  final List<CryptocurrencyModel> bitcoins;
  final List<CryptocurrencyModel> ethereums;
  final List<CryptocurrencyModel> solanas;
  final List<CryptocurrencyModel> latestSemantics;

  const CryptoDataLoaded({
    required this.bitcoins,
    required this.ethereums,
    required this.solanas,
    required this.latestSemantics,
  });

  @override
  List<Object?> get props => [bitcoins, ethereums, solanas];
}
