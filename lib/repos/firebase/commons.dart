import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/data/actions/action_enums.dart';
import 'package:coup/modals/firebase/fbModels.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/game/actions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirebaseCommons {
  static final _db = FirebaseDatabase.instance;

  static updateIsk(num incValue) async {
    _db
        .reference()
        .child('players/' + IDManager.selfId + '/isk')
        .runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + incValue;
      return mutableData;
    });
  }

  static setTurnState(GameState state) async {
    var _turnRef = _db.reference().child('turns/' + IDManager.turnId);
    // return await _db
    //     .collection('players')
    //     .document(IDManager.turnId)
    //     .updateData({"gameState": state});
  }

  static changeTurn() async {
    final HttpsCallable _changeActive = CloudFunctions.instance
        .getHttpsCallable(functionName: 'turn-changeActive');

    return await _changeActive
        .call({"tableId": IDManager.tableId, "playerId": IDManager.selfId});
  }

  // killcard
  // swap card

  static Future<void> addTurn(BuildContext context, CardAction cardAction,
      {String effected, bool legal}) async {
    var _turnRef = _db.reference().child('turns/' + IDManager.turnId);
    // why send this to the server?
    bool end = !cardAction.blockable && !cardAction.challengeable;
    var state = end ? 'play' : 'counter';
    var data = cardAction.toMap();

    switch (cardAction.type) {
      case ActionType.action:
        return await _turnRef.update({
          "action": {
            "name": data["action"],
            "end": end,
            "player": IDManager.selfId,
            "effectedP": effected?.toString(),
            "legal": legal
          },
          "hash": cardAction.hashCode.toString(),
          "gameState": state,
          "pipeline": data["action"]
        });
        break;
      case ActionType.ability:
        return await _turnRef.update({
          "block": {
            "name": data["action"],
            "end": end,
            "player": IDManager.selfId,
            "effectedP": effected.toString(),
            "legal": legal
          },
          "hash": cardAction.hashCode.toString(),
          "gameState": 'block',
        });
        break;
      case ActionType.passive:
        return await _turnRef.update({
          "passive": {
            "name": data["action"],
            "end": end,
            "player": IDManager.selfId,
            "effectedP": effected.toString(),
            "legal": legal
          },
          "hash": cardAction.hashCode.toString(),
          "gameState": state,
        });
        break;
      case ActionType.challenge:
        return await _turnRef.update({
          "challenge": {
            "name": data["action"],
            "end": end,
            "player": IDManager.selfId,
            "effectedP": effected.toString(),
            "legal": legal
          },
          "hash": cardAction.hashCode.toString(),
          "gameState": 'challenge',
        });
        break;
      default:
        break;
    }
  }
}
