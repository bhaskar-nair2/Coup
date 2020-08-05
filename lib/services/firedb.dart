import 'package:coup/modals/firebase/game_table.dart';
import 'package:coup/modals/firebase/player.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/firebase/turn.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:coup/repos/firebase/turn_consumer.dart';

@Deprecated("Dont use these functions")
class FireDB {
  static final FirebaseDatabase _db = FirebaseDatabase.instance;

  static Stream<GameTable> tableStream(String tableId) {
    return _db.reference().child('tables/' + tableId).onValue.map((event) {
      if (event.snapshot.value != null)
        return GameTable.fromRdb(event.snapshot.value);
      else
        return null;
    });
  }

  static Stream<SelfPlayer> selfStream(String userId) {
    return _db.reference().child('players/' + userId).onValue.map((event) {
      if (event.snapshot.value != null)
        return SelfPlayer.fromRdb(event.snapshot.value);
      else
        return null;
    });
  }

  static Stream<Turn> turnStream(String turnId) {
    return _db.reference().child('turns/' + turnId).onValue.map((event) {
      if (event.snapshot.value != null) {
        var _turn = Turn.fromRdb(event.snapshot.value);
        TurnConsumer.readTurn(_turn);
        return _turn;
      } else
        return null;
    });
  }

  static Stream<Player> playerStream(String playerId) {
    return _db.reference().child('players/' + playerId).onValue.map((event) {
      if (event.snapshot.value != null)
        return Player.fromRdb(event.snapshot.value);
      else
        return null;
    });
  }
}
