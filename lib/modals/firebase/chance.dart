import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:flutter/foundation.dart';

class Chance extends ChangeNotifier {
  // local chance system
  String activeId = '';
  bool active = false;
  int currentPos = 0; // not useful
  int selfPos = 0; // not useful
  int round = 0;

  final SelfPlayer _self = SelfPlayer();

  Chance();

  setActive(String playerId) {
    this.activeId = playerId;
    if (playerId == IDManager.selfId) {
      this.active = true;
    } else
      this.active = false;
  }

  setPos(pos) {
    this.selfPos = pos;
  }
}
