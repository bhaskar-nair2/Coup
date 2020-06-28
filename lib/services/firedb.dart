import 'package:coup/modals/firebase/game_table.dart';
import 'package:coup/modals/firebase/player.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/firebase/turn.dart';
import 'package:firebase_database/firebase_database.dart';

class FireDB {
  static final FirebaseDatabase _db = FirebaseDatabase.instance;

  static Stream<GameTable> tableStream(String tableId) {
    return _db.reference().child('tables/' + tableId).onValue.map((event) {
      if (event.snapshot.value != null)
        return GameTable.fromFirestore(event.snapshot.value);
      else
        return null;
    });
  }

  static Stream<SelfPlayer> selfStream(String userId) {
    return _db.reference().child('players/' + userId).onValue.map((event) {
      if (event.snapshot.value != null)
        return SelfPlayer.fromFirestore(event.snapshot.value);
      else
        return null;
    });
  }

  static Stream<Turn> turnStream(String turnId) {
    return _db.reference().child('turns/' + turnId).onValue.map((event) {
      if (event.snapshot.value != null)
        return Turn.fromFirestore(event.snapshot.value);
      else
        return Turn();
    });
  }

  static Stream<Player> playerStream(String playerId) {
    return _db.reference().child('players/' + playerId).onValue.map((event) {
      if (event.snapshot.value != null)
        return Player.fromFirestore(event.snapshot.value);
      else
        return null;
    });
  }
}
