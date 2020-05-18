import 'package:flutter/foundation.dart';

class Chance extends ChangeNotifier {
  String id;
  bool active;
  int currentPos;
  int selfPos;

  static final Chance _chance = Chance._internal();

  Chance._internal();

  factory Chance(pos) {
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
