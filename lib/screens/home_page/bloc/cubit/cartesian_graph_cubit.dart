import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infoviz_assign/models/cryptocurrency_model.dart';
import 'package:infoviz_assign/screens/home_page/bloc/crypto_data_bloc.dart';
import 'package:infoviz_assign/screens/home_page/widgets/custom_cartesian_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

part 'cartesian_graph_state.dart';

enum DateFilterType {
  hour12,
  day1,
  day7,
  month1,
}

class CartesianGraphCubit extends Cubit<CartesianGraphState> {
  CartesianGraphCubit({
    required List<CryptocurrencyModel> bitcoins,
    required List<CryptocurrencyModel> ethereums,
    required List<CryptocurrencyModel> solanas,
    required List<CryptocurrencyModel> latestSemantics,
    required DateTimeAxis dateTimeAxis,
    List<bool> coinsSelected = const [true, true, true],
  }) : super(
          CartesianGraphChanged(
            bitcoins: bitcoins,
            ethereums: ethereums,
            solanas: solanas,
            latestSemantics: latestSemantics,
            coinsSelected: coinsSelected,
            dateTimeAxis: dateTimeAxis,
          ),
        );

  void fold() {
    assert(state is CartesianGraphChanged);
    final castedState = state as CartesianGraphChanged;
    emit(castedState.copyWith(
      isFolded: true,
      zoomFactor: 1.0,
    ));
  }

  void unfold() {
    assert(state is CartesianGraphChanged);
    final castedState = state as CartesianGraphChanged;
    emit(castedState.copyWith(
      isFolded: false,
      zoomFactor: 1.0,
    ));
  }

  void updateCoinsVisibility(int index, bool value) {
    assert(state is CartesianGraphChanged);
    final castedState = state as CartesianGraphChanged;
    final newCoinsSelected = [...castedState.coinsSelected]; // clones the list
    newCoinsSelected[index] = value;

    emit(castedState.copyWith(coinsSelected: newCoinsSelected));
  }

  void filterByDate(DateFilterType type, CryptoDataLoaded dataState) {
    assert(state is CartesianGraphChanged);
    final castedState = state as CartesianGraphChanged;

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
      case DateFilterType.month1:
        cuttedListLength = 2880;
        dropdownText = '1M';
        break;
    }
    // Can't cut more than size of a list
    if (cuttedListLength > dataState.bitcoins.length) return;

    final bitcoins = dataState.bitcoins.sublist(0, cuttedListLength);
    final ethereums = dataState.ethereums.sublist(0, cuttedListLength);
    final solanas = dataState.solanas.sublist(0, cuttedListLength);

    emit(castedState.copyWith(
      bitcoins: bitcoins,
      ethereums: ethereums,
      solanas: solanas,
      filterByDateText: dropdownText,
    ));
  }

  void zoomIn() {
    assert(state is CartesianGraphChanged);
    final castedState = state as CartesianGraphChanged;

    final newZoom = (castedState.zoomFactor - 0.1).clamp(0.01, 1.0);
    castedState.zoomPanBehavior.zoomToSingleAxis(
      castedState.dateTimeAxis,
      0.5,
      newZoom,
    );
    castedState.zoomFactor = newZoom;
  }

  void zoomOut() {
    assert(state is CartesianGraphChanged);
    final castedState = state as CartesianGraphChanged;

    final newZoom = (castedState.zoomFactor + 0.1).clamp(0.01, 1.0);
    castedState.zoomPanBehavior.zoomToSingleAxis(
      castedState.dateTimeAxis,
      0.5,
      newZoom,
    );
    castedState.zoomFactor = newZoom;
  }

  TrackballBehavior getTrackballBehaviorByType(
      CartesianGraphType type, CryptoDataLoaded dataState) {
    switch (type) {
      case CartesianGraphType.price:
        return dataState.trackballBehaviorPrice;
      case CartesianGraphType.tweetCount:
        return dataState.trackballBehaviorTweetCount;
      case CartesianGraphType.semantics:
        return dataState.trackballBehaviorSemantics;
    }
  }
}
