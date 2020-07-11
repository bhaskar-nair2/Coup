import 'package:coup/modals/game/actions.dart';
import 'package:flutter/foundation.dart';

class Player extends ChangeNotifier {
  String playerId;
  String name = '';
  String nick = '';
  int cards = 0;
  int isk = 0;
  bool active = false;

  Player();

  Player.fromRdb(Map data) {
    this.name = data["name"];
    this.nick = data["nick"];
    this.cards = data["hand"]?.length ?? 0;
    this.isk = data["isk"];
  }
}

class PlayerAction {
  Player player;
  CardAction action;
}
