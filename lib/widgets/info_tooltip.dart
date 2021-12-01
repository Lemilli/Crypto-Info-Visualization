import 'package:flutter/material.dart';

class InfoTooltip extends StatelessWidget {
  const InfoTooltip({
    Key? key,
    this.message,
    this.richMessage,
    this.preferBelow,
    this.makeWhite,
  }) : super(key: key);

  final String? message;
  final InlineSpan? richMessage;
  final bool? preferBelow;
  final bool? makeWhite;

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
      child: Icon(
        Icons.info,
        size: 20,
        color: makeWhite == null ? null : Colors.white,
      ),
    );
  }
}
