import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infoviz_assign/models/cryptocurrency_model.dart';
import 'package:infoviz_assign/models/random_tweet.dart';
import 'package:infoviz_assign/network/crypto_repository.dart';
import 'package:infoviz_assign/screens/home_page/widgets/custom_cartesian_chart.dart';
import 'package:infoviz_assign/screens/home_page/widgets/trackball_pop_up.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

part 'crypto_data_event.dart';
part 'crypto_data_state.dart';

class CryptoDataBloc extends Bloc<CryptoDataEvent, CryptoDataState> {
  final _cryptoRepository = CryptoRepository();

  CryptoDataBloc() : super(CryptoDataInitial()) {
    on<GetCryptoData>(_mapGetCryptoDataEventToState);
  }

  void _mapGetCryptoDataEventToState(
      CryptoDataEvent event, Emitter<CryptoDataState> emit) async {
    emit(CryptoDataLoading());

    late final List<CryptocurrencyModel> bitcoins;
    late final List<CryptocurrencyModel> ethereums;
    late final List<CryptocurrencyModel> solanas;
    late final RandomTweet? randomBTC;
    late final RandomTweet? randomETH;
    late final RandomTweet? randomSOL;

    await Future.wait([
      _cryptoRepository.getBitcoins().then((result) => bitcoins = result),
      _cryptoRepository.getEthereums().then((result) => ethereums = result),
      _cryptoRepository.getSolanas().then((result) => solanas = result),
      _cryptoRepository
          .getRandomTweetBTC()
          .then((result) => randomBTC = result),
      _cryptoRepository
          .getRandomTweetETH()
          .then((result) => randomETH = result),
      _cryptoRepository
          .getRandomTweetSOL()
          .then((result) => randomSOL = result),
    ]);

    if (bitcoins.isEmpty || ethereums.isEmpty || solanas.isEmpty) {
      emit(const CryptoDataError('Network error. Try again later.'));
    } else {
      final _latestSemantics = <CryptocurrencyModel>[
        bitcoins.first,
        ethereums.first,
        solanas.first
      ];

      emit(CryptoDataLoaded(
        bitcoins: bitcoins,
        ethereums: ethereums,
        solanas: solanas,
        latestSemantics: _latestSemantics,
        randomTweetBTC: randomBTC,
        randomTweetETH: randomETH,
        randomTweetSOL: randomSOL,
      ));
    }
  }
}
