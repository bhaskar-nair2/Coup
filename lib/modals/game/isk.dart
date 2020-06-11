import 'package:flutter/foundation.dart';

class Isk extends ChangeNotifier {
  int _counter = 0;
  get counter => _counter;

  static final Isk _isk = Isk._internal();

  factory Isk(int value) {
    _isk.counter = value ?? 0;
    return _isk;
  }

  Isk._internal();

  set counter(int val) {
    if (val < 0)
      _counter = 0;
    else if (val > 99)
      _counter = 99;
    else
      _counter = val;
    notifyListeners();
  }

  increment(val) {
    counter = counter + val;
  }

  decrement(val) {
    counter = counter - val;
  }
}
