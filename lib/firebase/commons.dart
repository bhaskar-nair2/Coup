import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/modals/firebase/idmanager.dart';

class FirebaseCommons {
  static final _db = Firestore.instance;

  static updateIsk(num incValue) async {
    return await _db
        .collection('players')
        .document(IDManager.selfId)
        .updateData(<String, dynamic>{
      "isk": FieldValue.increment(incValue),
    });
  }

  static addActionTurn(Map data) async {
    final HttpsCallable _addTurnActionCall = CloudFunctions.instance
        .getHttpsCallable(functionName: 'turnFunctions-addTurn');

    return await _addTurnActionCall.call({
      "turnId": IDManager.turnId,
      "tableId": IDManager.tableId,
      "playerId": IDManager.selfId,
      "type": "action",
      "action": {
        ...data,
        "player": IDManager.selfId,
      }
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
