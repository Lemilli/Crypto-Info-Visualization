import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GlobalHelper {
  // Singleton
  static final GlobalHelper _instance = GlobalHelper._internal();

  factory GlobalHelper() {
    return _instance;
  }

  GlobalHelper._internal();

  static final cryptoNames = ['Bitcoin', 'Ethereum', 'Solana'];
  // order : btc, eth, sol
  static final cryptosColors = [Colors.orange, Colors.grey, Colors.blue];
  static final cryptoImages = [
    'assets/images/btc.png',
    'assets/images/eth.png',
    'assets/images/sol.png',
  ];

  static final _formatter = NumberFormat.decimalPattern();
  static String formatDecimalPattern(dynamic number) {
    return _formatter.format(number);
  }
}
