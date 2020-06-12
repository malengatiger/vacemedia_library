library vacemedia_library;

import 'package:flutter/cupertino.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

void p(dynamic message) {
  if (message is String) {
    debugPrint('${DateTime.now().toIso8601String()} ==> $message');
  } else {
    print(message);
  }
}
