import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infoviz_assign/models/cryptocurrency_model.dart';
import 'package:infoviz_assign/screens/home_page/bloc/crypto_data_bloc.dart';

part 'cartesian_graph_state.dart';

enum DateFilterType {
  hour12,
  day1,
  day7,
}

class CartesianGraphCubit extends Cubit<CartesianGraphState> {
  CartesianGraphCubit({
    required List<CryptocurrencyModel> bitcoins,
    required List<CryptocurrencyModel> ethereums,
    required List<CryptocurrencyModel> solanas,
    required List<CryptocurrencyModel> latestSemantics,
    List<bool> coinsSelected = const [true, true, true],
  }) : super(
          CartesianGraphChanged(
            bitcoins: bitcoins,
            ethereums: ethereums,
            solanas: solanas,
            latestSemantics: latestSemantics,
            coinsSelected: coinsSelected,
          ),
        );

  void fold() {
    if (state is CartesianGraphChanged) {
      final castedState = state as CartesianGraphChanged;
      emit(castedState.copyWith(isFolded: true));
    }
  }

  void unfold() {
    if (state is CartesianGraphChanged) {
      final castedState = state as CartesianGraphChanged;
      emit(castedState.copyWith(isFolded: false));
    }
  }

  void updateCoinsVisibility(int index, bool value) {
    if (state is CartesianGraphChanged) {
      final castedState = state as CartesianGraphChanged;
      final newCoinsSelected = [
        ...castedState.coinsSelected
      ]; // clones the list
      newCoinsSelected[index] = value;

      emit(castedState.copyWith(coinsSelected: newCoinsSelected));
    }
  }

  void filterByDate(DateFilterType type, CryptoDataLoaded dataState) {
    if (state is CartesianGraphChanged) {
      final cartesianState = state as CartesianGraphChanged;
      late final DateTime splitDatetime;

      switch (type) {
        case DateFilterType.hour12:
          splitDatetime = DateTime.now().subtract(const Duration(hours: 12));
          break;
        case DateFilterType.day1:
          splitDatetime = DateTime.now().subtract(const Duration(days: 1));
          break;
        case DateFilterType.day7:
          splitDatetime = DateTime.now().subtract(const Duration(days: 7));
          break;
      }

      for (int i = dataState.bitcoins.length - 1; i >= 0; i--) {
        if (dataState.bitcoins[i].datetime.isBefore(splitDatetime)) {
          final bitcoins =
              dataState.bitcoins.sublist(i, dataState.bitcoins.length);
          final ethereums =
              dataState.ethereums.sublist(i, dataState.ethereums.length);
          final solanas =
              dataState.solanas.sublist(i, dataState.solanas.length);

          emit(cartesianState.copyWith(
            bitcoins: bitcoins,
            ethereums: ethereums,
            solanas: solanas,
          ));
          break;
        }
      }
    }
  }

  // binarySearch(List<int> arr, int userValue, int min, int max) {
  //   if (max >= min) {
  //     int mid = ((max + min) / 2).floor();
  //     if (userValue == arr[mid]) {
  //       print('your item is at index: ${mid}');
  //     } else if (userValue > arr[mid]) {
  //       binarySearch(arr, userValue, mid + 1, max);
  //     } else {
  //       binarySearch(arr, userValue, min, mid - 1);
  //     }
  //   }
  //   return null;
  // }
}
