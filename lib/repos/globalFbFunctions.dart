import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/modals/game_table.dart';
import 'package:coup/modals/self.dart';
import 'package:coup/modals/turn.dart';

class FbFunctions {
  final _db = Firestore.instance;
  final SelfPlayer _self = SelfPlayer();
  final GameTable _table = GameTable();
  final Turn _turn = Turn();

  updateIsk(num incValue) async {
    return await _self.ref.updateData(<String, dynamic>{
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
