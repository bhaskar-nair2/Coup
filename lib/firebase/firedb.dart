import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/game_table.dart';

class FirestoreService {
  final Firestore _db = Firestore.instance;

  Stream<GameTable> tableStream(String tableId) {
    return _db
        .collection('tables')
        .document(tableId)
        .snapshots()
        .map((snap) => GameTable.fromMap(snap));
  }
}
