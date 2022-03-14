import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infoviz_assign/models/cryptocurrency_model.dart';

part 'cartesian_graph_state.dart';

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
}
