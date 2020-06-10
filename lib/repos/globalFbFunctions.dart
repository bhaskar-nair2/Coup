import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/modals/firebase/game_table.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/firebase/turn.dart';

class FbFunctions {
  final _db = Firestore.instance;
  final SelfPlayer _self = SelfPlayer();
  final GameTable _table = GameTable();
  final Turn _turn = Turn();

  updateIsk(num incValue) async {
    return await _db
        .collection('players')
        .document(_self.uid)
        .updateData(<String, dynamic>{
      "isk": FieldValue.increment(incValue),
    });
  }

  addActionTurn(Map data) async {
    final HttpsCallable _addTurnActionCall = CloudFunctions.instance
        .getHttpsCallable(functionName: 'turnFunctions-addTurn');

    return await _addTurnActionCall.call({
      "turnId": _turn.id,
      "tableId": _table.tableId,
      "userId": _self.uid,
      "action": {
        "type": data["action"],
        "player": _self.uid,
      }
    });
  }
}
