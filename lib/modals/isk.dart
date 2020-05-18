import 'package:flutter/cupertino.dart';

class Isk extends ChangeNotifier {
  int _counter = 0;
  get counter => _counter;

  static final Isk _isk = Isk._internal();

  factory Isk() {
    return _isk;
  }

  Isk._internal();

  set counter(int val) {
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
