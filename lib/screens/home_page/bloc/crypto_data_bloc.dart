import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infoviz_assign/models/cryptocurrency_model.dart';
import 'package:infoviz_assign/network/crypto_repository.dart';
import 'package:meta/meta.dart';

part 'crypto_data_event.dart';
part 'crypto_data_state.dart';

class CryptoDataBloc extends Bloc<CryptoDataEvent, CryptoDataState> {
  CryptoDataBloc() : super(CryptoDataInitial()) {
    final _cryptoRepository = CryptoRepository();

    on<CryptoDataEvent>((event, emit) async {
      if (event is GetCryptoData) {
        emit(CryptoDataLoading());
        final _bitcoins = await _cryptoRepository.getBitcoins();
        final _ethereums = await _cryptoRepository.getEthereums();
        final _solanas = await _cryptoRepository.getSolanas();

        if (_bitcoins.isEmpty || _ethereums.isEmpty || _solanas.isEmpty) {
          emit(const CryptoDataError('Network error. Try again later.'));
        } else {
          final _latestSemantics = <CryptocurrencyModel>[
            _bitcoins.last,
            _ethereums.last,
            _solanas.last
          ];

          emit(CryptoDataLoaded(
            bitcoins: _bitcoins,
            ethereums: _ethereums,
            solanas: _solanas,
            latestSemantics: _latestSemantics,
          ));
        }
      }
    });
  }
}
