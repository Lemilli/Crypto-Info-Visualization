import 'package:flutter/material.dart';

class InfoTooltip extends StatelessWidget {
  const InfoTooltip({
    Key? key,
    this.message,
    this.richMessage,
    this.preferBelow,
  }) : super(key: key);

  final String? message;
  final InlineSpan? richMessage;
  final bool? preferBelow;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: richMessage == null ? message : null,
      richMessage: richMessage,
      preferBelow: preferBelow,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: const Icon(
        Icons.info,
        size: 20,
      ),
    );
  }
}
