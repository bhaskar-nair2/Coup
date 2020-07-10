import 'package:coup/modals/game/chance.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/game/action.dart';
import 'package:coup/repos/firebase/turnConsumer.dart';
import 'package:flutter/foundation.dart';

enum GameState { pause, play, counter, block, challenge }

class Turn {
  String id = ''; // id of turn from table
  TurnAction action;
  var block;
  var challenge;
  GameState gameState;
  String pin;
  String activeId;
  String hash;

  Turn();

  Chance get chance {
    switch (this.gameState) {
      case GameState.play:
        return Chance(active: this.activeId == IDManager.selfId); // 1 active
      case GameState.counter:
        return Chance(active: true); // All active
      default:
        return Chance(active: false);
    }
  }

  Turn.fromRdb(Map data) {
    this.activeId = data['active'];
    this.action = TurnAction(data["action"] as Map);
    this.block = TurnBlock(data["block"] as Map);
    this.challenge = TurnChallenge(data["challenge"] as Map);
    this.gameState = stateFromStr(((data['gameState'] ?? 'pause') as String));
    this.hash = data['hash'].toString();
    TurnConsumer.readTurn(this);
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
      this.player = data['player'] ?? null; // TODO:
      this.type = CardAction.actionFromStr(data['name']);
    }
  }
}

class TurnBlock {
  var player;
  // BlockName type;

  TurnBlock(data) {
    if (data != null) {
      this.player = data['player'] ?? null; // TODO:
      // this.type = CardAction.actionFromStr(data['name']);
    }
  }
}

class TurnChallenge {
  var player;

  TurnChallenge(data) {
    if (data != null) {
      this.player = data['player'] ?? null; // TODO:
    }
  }
}
