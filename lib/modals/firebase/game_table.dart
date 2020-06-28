import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/player.dart';
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

  GameTable.fromFirestore(Map data) {
    List<String> _players =
        List.castFrom((data['players'] as Map).keys.toList());
    this.players = _players;
    this.owner = data['owner'];
    this.state = stateFromStr((data['state'] as String));
    this.inProgress = data['inProgress'];

    if (this.inProgress == false) {
      this.pin = data['pin'];
      this.turnId = data["turn"];
    }
  }
  static TableState stateFromStr(String str) {
    TableState state = TableState.values.firstWhere(
        (e) => e.toString() == 'TableState.' + str.toString().toLowerCase());
    return state;
  }
}
