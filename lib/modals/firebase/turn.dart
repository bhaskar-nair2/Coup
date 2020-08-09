import 'package:coup/modals/game/chance.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/game/actions.dart';
import 'package:coup/repos/firebase/turn_consumer.dart';

enum GameState { pause, play, counter, block, challenge, kill, end }

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
    return Chance(active: this.activeId == IDManager.selfId);
    switch (gameState) {
      case GameState.play:
        return Chance(active: this.activeId == IDManager.selfId);
      case GameState.counter:
        return Chance(active: true);
      case GameState.block:
      case GameState.challenge:
        return Chance(active: this.activeId == IDManager.selfId);
      case GameState.kill:
        return Chance(active: this.activeId == action.effectedPlayer);
      default:
        return Chance(active: false);
    }
  }

  Turn.fromRdb(Map data) {
    if (data != null) {
      this.activeId = data['active'];
      this.action = TurnAction(data["action"] as Map);
      this.block = TurnBlock(data["block"] as Map);
      this.challenge = TurnChallenge(data["challenge"] as Map);
      this.gameState = stateFromStr(((data['gameState'] ?? 'pause') as String));
      this.hash = data['hash'].toString();
      TurnConsumer.readTurn(this);
    }
  }

  static GameState stateFromStr(String str) {
    GameState state = GameState.values.firstWhere(
        (e) => e.toString() == 'GameState.' + str.toString().toLowerCase());
    return state;
  }
}

class TurnAction {
  String player;
  CardAction type;
  String effectedPlayer;

  TurnAction(data) {
    if (data != null) {
      this.player = data['player'] ?? null; // TODO:
      this.type = CardAction.actionFromStr(data['name']);
      this.effectedPlayer = data["effectedP"] ?? null;
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
