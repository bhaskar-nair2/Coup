import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/firebase/chance.dart';
import 'package:flutter/foundation.dart';

class Turn extends ChangeNotifier {
  String id = ''; // id of turn from table
  var action;
  var block;
  var challenge;
  Chance chance = Chance();

  Turn();

  set turnId(String turnId) {
    this.id = turnId;
  }

  Turn.fromFirestore(DocumentSnapshot snap) {
    this.action = snap["action"] ?? null;
    this.block = snap["block"] ?? null;
    this.challenge = snap["challenge"] ?? null;
    this.chance.setActive((snap['active'] as DocumentReference).documentID);
  }
}
