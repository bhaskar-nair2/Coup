import 'package:coup/modals/game/chance.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/game/action.dart';
import 'package:coup/repos/turnReader.dart';
import 'package:flutter/foundation.dart';

enum GameState { pause, play, counter, block, challenge }

class Turn extends ChangeNotifier {
  String id = ''; // id of turn from table
  TurnAction action;
  var block;
  var challenge;
  GameState gameState = GameState.pause;
  Chance chance = Chance();
  String pin;

  Turn();

  set turnId(String turnId) {
    this.id = turnId;
    IDManager.turnId = turnId;
  }

  Turn.fromRdb(Map data) {
    this.action = TurnAction(data["action"] as Map) ?? null;
    this.block = data["block"] ?? null;
    this.challenge = data["challenge"] ?? null;
    this.gameState = stateFromStr(((data['gameState'] ?? 'loading') as String));

    TurnReader.readTurn(this);
    this.setCurrActive(data);
  }

  setCurrActive(Map data) {
    switch (this.gameState) {
      case GameState.play:
        this.chance.setActive(data['active'] as String);
        break;

      default:
        this.chance.active = false;
        break;
    }
  }

  static GameState stateFromStr(String str) {
    GameState state = GameState.values.firstWhere(
        (e) => e.toString() == 'GameState.' + str.toString().toLowerCase());
    return state;
  }
}

class TurnAction {
  var player;
  ActionName type;

  TurnAction(data) {
    if (data != null) {
      this.player = data['player'] ?? null;
      this.type = CardAction.actionFromStr(data['action']);
    }
  }
}
