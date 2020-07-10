import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:firebase_database/firebase_database.dart';

class SelfService {
  final FirebaseDatabase _db = FirebaseDatabase.instance;
  DatabaseReference _ref;

  SelfService() {
    _ref = _db.reference().child('players/' + IDManager.selfId);
  }

  Stream<SelfPlayer> streamData() {
    return _ref.onValue
        .map((event) => SelfPlayer.fromRdb(event.snapshot.value));
  }

  Future<SelfPlayer> getDocument() async {
    return _ref.once().then((v) => SelfPlayer.fromRdb(v.value));
  }

  Future<void> upsert(Map data) async {
    return _ref.update(Map<String, dynamic>.from(data));
  }
}
