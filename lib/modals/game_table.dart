import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/player.dart';
import 'package:coup/modals/turn.dart';
import 'package:flutter/material.dart';

class GameTable extends ChangeNotifier {
  DocumentReference ref;
  int occupied=0;
  List<Player> players;
  List<Turn> turn;

  static final GameTable _table = GameTable._internal();

  GameTable._internal();

  factory GameTable(docId) {
    _table.ref = Firestore.instance.document('tables/$docId');
    _table.initGameTableData();
    return _table;
  }

  initGameTableData() async* {
    this.ref.snapshots().listen((DocumentSnapshot snap) {
      this.occupied = snap.data['occupied'];
      this.players = List.generate(this.occupied,
          (index) =>  Player.fromMap(snap.data["players"][index]));
    });
  }
}
