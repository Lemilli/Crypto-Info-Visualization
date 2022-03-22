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
      late final int cuttedListLength;
      late final String dropdownText;

      // Length of the values is based on the fact that there's 1 data item each 15 minutes
      // It means that there's 4 items each hour
      // 12 hours: 12 * 4 = 48 items
      switch (type) {
        case DateFilterType.hour12:
          cuttedListLength = 48;
          dropdownText = '12H';
          break;
        case DateFilterType.day1:
          cuttedListLength = 96;
          dropdownText = '1D';
          break;
        case DateFilterType.day7:
          cuttedListLength = 672;
          dropdownText = '7D';
          break;
      }
      // Can't cut more than size of a list
      if (cuttedListLength > dataState.bitcoins.length) return;

      final bitcoins = dataState.bitcoins.sublist(0, cuttedListLength);
      final ethereums = dataState.ethereums.sublist(0, cuttedListLength);
      final solanas = dataState.solanas.sublist(0, cuttedListLength);

      emit(cartesianState.copyWith(
        bitcoins: bitcoins,
        ethereums: ethereums,
        solanas: solanas,
        filterByDateText: dropdownText,
      ));
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
