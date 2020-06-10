import 'package:coup/modals/game/action.dart';
import 'package:flutter/foundation.dart';

class Player {
  String playerId;
  String name = '';
  String nick = '';
  int cards = 0;
  int isk = 0;
  bool active = false;

  Player({@required this.playerId});

  static Player fromFirebase(Map<String, dynamic> map, active) {
    return Player(
      playerId: map['player'], // playerREf
      // name: map["name"],
      // cards: map['hand'].length,
      // isk: map['isk'],
      // nick: map["nick"],
      // active: active,
    );
  }

  // String toJson() => json.encode(toMap());
}

class PlayerAction {
  Player player;
  CardAction action;
}
