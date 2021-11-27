import 'package:flutter/material.dart';

class ConstVariables {
  // Singleton just in case
  static final ConstVariables _instance = ConstVariables._internal();

  factory ConstVariables() {
    return _instance;
  }

  ConstVariables._internal();

  static final cryptosColors = [Colors.red, Colors.blue, Colors.orange];
}
