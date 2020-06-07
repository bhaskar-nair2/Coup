import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/player.dart';

class Turn {
  DocumentReference ref;

  Turn();

  factory Turn.fromRef(DocumentReference ref) {
    Turn turn = Turn();
    turn.ref = ref;
    return turn;
  }

}
