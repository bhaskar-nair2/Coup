import 'package:coup/modals/firebase/self.dart';
import 'package:flutter/foundation.dart';

class Chance extends ChangeNotifier {
  // local chance system
  String activeId = '';
  bool active = false;
  int currentPos = 0; // not useful
  int selfPos = 0; // not useful
  int round = 0;

  static final Chance _chance = Chance._internal();
  Chance._internal();

  final SelfPlayer _self = SelfPlayer();

  factory Chance() {
    return _chance;
  }

  setActive(String playerId) {
    this.activeId = playerId;
    if (playerId == _self.uid) {
      this.active = true;
    } else
      this.active = false;
  }

  setPos(pos) {
    this.selfPos = pos;
  }
}
