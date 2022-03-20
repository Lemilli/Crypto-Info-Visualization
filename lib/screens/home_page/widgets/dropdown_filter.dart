import 'package:flutter/material.dart';

class DropdownFilter extends StatelessWidget {
  const DropdownFilter({
    Key? key,
    required this.hintText,
    required this.items,
  }) : super(key: key);

  final String hintText;
  final List<DropdownMenuItem<String>> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: DropdownButton<String>(
        value: null,
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
