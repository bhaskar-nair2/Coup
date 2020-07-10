import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:firebase_database/firebase_database.dart';

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

  static setTurnState(String state) async {
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

  static addTurn(Map data) async {
    var turnRef = _db.reference().child('turns/' + IDManager.turnId);

    bool end = !data['blockable'] || !data['challengeable'];

    var state = end ? 'play' : 'counter';

    return await turnRef.update({
      "action": {
        "name": data['action'],
        "end": end,
        "player": IDManager.selfId,
        "effectedP": data['effected'] ?? null
      },
      "hash": data.hashCode,
      "gameState": state,
    });
  }

  static addChallengeTurn(Map data) async {
    final HttpsCallable _addTurnActionCall = CloudFunctions.instance
        .getHttpsCallable(functionName: 'turnFunctions-addTurn');

    return await _addTurnActionCall.call({
      "turnId": IDManager.turnId,
      "tableId": IDManager.tableId,
      "playerId": IDManager.selfId,
      "type": "challenge",
      "block": {
        ...data,
        "player": IDManager.selfId,
      }
    });
  }

  static addBlockTurn(Map data) async {
    final HttpsCallable _addTurnActionCall = CloudFunctions.instance
        .getHttpsCallable(functionName: 'turnFunctions-addTurn');

    return await _addTurnActionCall.call({
      "turnId": IDManager.turnId,
      "tableId": IDManager.tableId,
      "playerId": IDManager.selfId,
      "type": "block",
      "block": {
        ...data,
        "player": IDManager.selfId,
      }
    });
  }
}
