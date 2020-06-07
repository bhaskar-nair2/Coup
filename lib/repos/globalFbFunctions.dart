import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/game_table.dart';
import 'package:coup/modals/self.dart';

class FbFunctions {
  final _db = Firestore.instance;
  final SelfPlayer _self = SelfPlayer();
  final GameTable _table = GameTable();

  updateIsk(num incValue) async {
    return await _self.ref.updateData(<String, dynamic>{
      "isk": FieldValue.increment(incValue),
    });
  }

  addActionTurn(Map data) async {
    DocumentReference turn = _table.turn.ref;

    await turn.updateData({
      "actions": FieldValue.arrayUnion([
        {
          "player": _self.ref,
          "action": data["action"],
        }
      ])
    });
  }
}
