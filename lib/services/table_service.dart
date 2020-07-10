import 'dart:async';

import 'package:coup/modals/firebase/fbModels.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:firebase_database/firebase_database.dart';

class TableService {
  final FirebaseDatabase _db = FirebaseDatabase.instance;
  DatabaseReference _ref;

  TableService() {
    _ref = _db.reference().child('tables/' + IDManager.tableId);
  }

  Stream<GameTable> streamData() {
    return _ref.onValue.map((event) => GameTable.fromRdb(event.snapshot.value));
  }

  Future getDocument() async {
    return _ref.once().then((v) => GameTable.fromRdb(v.value));
  }

  Future<void> upsert(Map data) async {
    return _ref.update(Map<String, dynamic>.from(data));
  }
}
