part of 'crypto_data_bloc.dart';

@immutable
abstract class CryptoDataEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCryptoData extends CryptoDataEvent {}
