import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/firebase/game_table.dart';
import 'package:coup/modals/firebase/player.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/firebase/turn.dart';

class FirestoreService {
  static final Firestore _db = Firestore.instance;

  static Stream<GameTable> tableStream(String tableId) {
    return _db.collection('tables').document(tableId).snapshots().map((snap) {
      if (snap.exists)
        return GameTable.fromFirestore(snap);
      else
        return GameTable();
    });
  }

  static Stream<SelfPlayer> selfStream(String userId) {
    return _db.collection('players').document(userId).snapshots().map((snap) {
      if (snap.exists)
        return SelfPlayer.fromFirestore(snap);
      else
        return SelfPlayer();
    });
  }

  static Stream<Turn> turnStream(String turnId) {
    return _db.collection('turns').document(turnId).snapshots().map((snap) {
      if (snap.exists)
        return Turn.fromFirestore(snap);
      else
        return Turn();
    });
  }

  static Stream<Player> playerStream(String playerId) {
    return _db.collection('players').document(playerId).snapshots().map((snap) {
      if (snap.exists)
        return Player.fromFirestore(snap);
      else
        return Player();
    });
  }
}
