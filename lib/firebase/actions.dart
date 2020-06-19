import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/modals/firebase/idmanager.dart';

class FbTurnFunctions {
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
      "action": {
        ...data,
        "player": IDManager.selfId,
      }
    });
  }
}
