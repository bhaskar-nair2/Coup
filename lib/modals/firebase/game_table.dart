import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum TableState { loading, waiting, play, score }

class GameTable extends ChangeNotifier {
  String tableId;
  int occupied = 0; // Exact number, index from 1
  String turnId = '';
  List<String> players = [];
  String owner;
  String pin;
  TableState state;
  bool inProgress;

  GameTable();

  GameTable.fromRdb(Map data) {
    List<String> _players =
        List.castFrom((data['players'] as Map).keys.toList());
    this.players = _players;
    this.owner = data['owner'];
    this.state = stateFromStr((data['state'] as String));
    this.pin = data['pin'];
    this.turnId = data["turn"];
  }
  static TableState stateFromStr(String str) {
    TableState state = TableState.values.firstWhere(
        (e) => e.toString() == 'TableState.' + str.toString().toLowerCase());
    return state;
  }
}
