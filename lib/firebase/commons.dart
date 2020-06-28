import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseCommons {
  static final _db = FirebaseDatabase.instance;

  static updateIsk(num incValue) async {
    // return await _db
    //     .collection('players')
    //     .document(IDManager.selfId)
    //     .updateData(<String, dynamic>{
    //   "isk": FieldValue.increment(incValue),
    // });
  }

  static setTurnState(String state) async {
    // return await _db
    //     .collection('players')
    //     .document(IDManager.turnId)
    //     .updateData({"gameState": state});
  }

  static changeActive(String nextPlayerId) async {
    // return await _db.collection('turns').document(IDManager.turnId).updateData(
    //     {"active": _db.collection('players').document(nextPlayerId)});
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
      },
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
