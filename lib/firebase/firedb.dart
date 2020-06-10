import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/firebase/game_table.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/firebase/turn.dart';

class FirestoreService {
  final Firestore _db = Firestore.instance;

  Stream<GameTable> tableStream(String tableId) {
    return _db
        .collection('tables')
        .document(tableId)
        .snapshots()
        .map((snap) => GameTable.fromFirestore(snap));
  }

  Stream<SelfPlayer> selfStream(String userId) {
    return _db
        .collection('players')
        .document(userId)
        .snapshots()
        .map((snap) => SelfPlayer.fromFirestore(snap));
  }

  Stream<Turn> turnStream(String turnId) {
    print('xxxxxxxxxxxxxxxxxxxx $turnId');
    return _db
        .collection('turns')
        .document(turnId)
        .snapshots()
        .map((snap) => Turn.fromFirestore(snap));
  }
}
