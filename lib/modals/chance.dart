import 'package:flutter/foundation.dart';

class Chance extends ChangeNotifier {
  String id;
  bool active = false;
  int currentPos = 0;
  int selfPos = 0;
  int round = 0;

  static final Chance _chance = Chance._internal();

  Chance._internal();

  factory Chance() {
    return _chance;
  }

  factory Chance.withPos(pos) {
    _chance.selfPos = pos;
    return _chance;
  }

  setCurrent(int current) {
    this.currentPos = current;
    if (current == selfPos) {
      this.active = true;
    } else {
      this.active = false;
    }
    notifyListeners();
  }
}
