import 'package:coup/modals/firebase/fbModels.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:firebase_database/firebase_database.dart';

class TurnService {
  final FirebaseDatabase _db = FirebaseDatabase.instance;
  DatabaseReference _ref;

  TurnService() {
    _ref = _db.reference().child('turns/' + IDManager.turnId);
  }

  Stream<Turn> streamData() {
    return _ref.onValue.map((event) => Turn.fromRdb(event.snapshot.value));
  }

  Future<Turn> getDocument() async {
    return _ref.once().then((v) => Turn.fromRdb(v.value));
  }

  Future<void> upsert(Map data) async {
    return _ref.update(Map<String, dynamic>.from(data));
  }
}
