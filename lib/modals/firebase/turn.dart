import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/firebase/firedb.dart';
import 'package:flutter/foundation.dart';

class Turn extends ChangeNotifier {
  String id; // id of turn from table
  String active; // id of active player
  var action;
  var block;
  var challenge;

  // singleton
  static final Turn _turn = Turn._internal();
  Turn._internal();

  factory Turn() {
    return _turn;
  }

  factory Turn.fromFirestore(DocumentSnapshot snap) {
    _turn.action = snap["action"] ?? null;
    _turn.block = snap["block"] ?? null;
    _turn.challenge = snap["challenge"] ?? null;
    return _turn;
  }
}
