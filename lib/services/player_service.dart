import 'package:coup/modals/firebase/player.dart';
import 'package:firebase_database/firebase_database.dart';

class PlayerService {
  final FirebaseDatabase _db = FirebaseDatabase.instance;
  DatabaseReference _ref;

  PlayerService(String playerId) {
    _ref = _db.reference().child('players/' + playerId);
  }

  Stream<Player> streamData() {
    return _ref.onValue.map((event) => Player.fromRdb(event.snapshot.value));
  }

  Future<Player> getDocument() async {
    return _ref.once().then((v) => Player.fromRdb(v.value));
  }

  Future<void> upsert(Map data) async {
    return _ref.update(Map<String, dynamic>.from(data));
  }
}
