import 'package:coup/modals/self.dart';
import 'package:flutter/foundation.dart';

class Chance extends ChangeNotifier {
  // local chance system
  String activeId;
  bool active = false;
  int currentPos = 0; // not useful
  int selfPos = 0; // not useful
  int round = 0;

  static final SelfPlayer _self = SelfPlayer();

  static final Chance _chance = Chance._internal();

  Chance._internal();

  factory Chance() {
    return _chance;
  }

  setActive(playerId) {
    if (playerId == _self.uid) {
      _chance.active = true;
    } else
      _chance.active = false;
  }

  setPos(pos) {
    _chance.selfPos = pos;
  }
}
