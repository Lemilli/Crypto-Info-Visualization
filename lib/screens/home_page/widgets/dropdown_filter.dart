import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoviz_assign/screens/home_page/bloc/cubit/cartesian_graph_cubit.dart';

class DropdownFilter extends StatelessWidget {
  const DropdownFilter({
    Key? key,
    required this.hintText,
    required this.items,
    this.showSelected = false,
  }) : super(key: key);

  final String hintText;
  final List<DropdownMenuItem<String>> items;
  final bool showSelected;

  @override
  Widget build(BuildContext context) {
    assert(BlocProvider.of<CartesianGraphCubit>(context).state
        is CartesianGraphChanged);
    final state = BlocProvider.of<CartesianGraphCubit>(context).state
        as CartesianGraphChanged;

    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: DropdownButton<String>(
        value: showSelected ? state.filterByDateText : null,
        isExpanded: true,
        underline: const SizedBox(),
        focusColor: Colors.transparent,
        items: items,
        onChanged: (_) {},
        hint: Text(hintText),
      ),
    );
  }
}
