import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/firebase/firedb.dart';
import 'package:coup/modals/chance.dart';
import 'package:coup/modals/self.dart';

class Turn {
  // used for global turn system, the chance is diffrent
  DocumentReference ref;
  String id;
  Chance chance;
  var action;
  var block;
  var challenge;

  static final Turn _turn = Turn._internal();
  static final FirestoreService _fs = FirestoreService();

  Turn._internal();

  static startStrem(String turnId) {
    _fs.turnStream(turnId);
  }

  get turnStream => _fs.turnStream(ref.documentID);

  factory Turn() {
    return _turn;
  }

  factory Turn.fromRef(DocumentReference ref) {
    print('$ref');
    _turn.ref = ref;
    _turn.id = ref.documentID;
    _fs.turnStream(ref.documentID);
    return _turn;
  }

  factory Turn.fromFirestore(DocumentSnapshot snap) {
    print('XXXXXX');
    _turn.action = snap["action"] ?? null;
    _turn.block = snap["block"] ?? null;
    _turn.challenge = snap["challenge"] ?? null;
    return _turn;
  }
}
