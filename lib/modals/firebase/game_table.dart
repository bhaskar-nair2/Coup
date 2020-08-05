import 'package:coup/modals/firebase/idmanager.dart';

enum TableState { loading, waiting, play, score }

class GameTable {
  String tableId;
  int occupied = 0; // Exact number, index from 1
  String turnId;
  List<String> players = [];
  String owner;
  String pin;
  TableState state;
  bool inProgress;

  GameTable.fromRdb(Map data) {
    if (data != null) {
      // get the list of players ans convert it to the reference object
      List<String> _players =
          List.castFrom((data['players'] as Map ?? {}).keys.toList());
      this.players = _players;
      this.owner = data['owner'];
      this.state = stateFromStr((data['state'] as String));
      this.pin = data['pin'];
      if (this.turnId != data['turn']) {
        this.turnId = data["turn"];
        IDManager.turnId = this.turnId;
      }
    }
  }

  static TableState stateFromStr(String str) {
    TableState state = TableState.values.firstWhere(
        (e) => e.toString() == 'TableState.' + str.toString().toLowerCase());
    return state;
  }
}
