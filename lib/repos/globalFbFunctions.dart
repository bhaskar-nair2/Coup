import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/modals/firebase/game_table.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/firebase/turn.dart';

class FbFunctions {
  final _db = Firestore.instance;

  updateIsk(num incValue) async {
    return await _db
        .collection('players')
        .document(IDManager.selfId)
        .updateData(<String, dynamic>{
      "isk": FieldValue.increment(incValue),
    });
  }

  addActionTurn(Map data) async {
    final HttpsCallable _addTurnActionCall = CloudFunctions.instance
        .getHttpsCallable(functionName: 'turnFunctions-addTurn');

    print("TurnId: ${IDManager.turnId}");

    return await _addTurnActionCall.call({
      "turnId": IDManager.turnId,
      "tableId": IDManager.tableId,
      "playerId": IDManager.selfId,
      "action": {
        "type": data["action"],
        "player": IDManager.selfId,
      }
    });
  }
}
