import 'package:flutter/material.dart';

class TopNavigationButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const TopNavigationButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: const Color(0x77777777),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
