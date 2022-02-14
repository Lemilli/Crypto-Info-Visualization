import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConstVariables {
  // Singleton just in case
  static final ConstVariables _instance = ConstVariables._internal();

  factory ConstVariables() {
    return _instance;
  }

  ConstVariables._internal();

  static final cryptoNames = ['Bitcoin', 'Ethereum', 'Solana'];
  // order : btc, eth, sol
  static final cryptosColors = [Colors.orange, Colors.grey, Colors.blue];
  static final cryptoImages = [
    'images/btc.png',
    'images/eth.png',
    'images/sol.png',
  ];

  static final _formatter = NumberFormat.decimalPattern();
  static String formatDecimalPattern(dynamic number) {
    return _formatter.format(number);
  }
}
