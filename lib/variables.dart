import 'package:flutter/material.dart';

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
}
