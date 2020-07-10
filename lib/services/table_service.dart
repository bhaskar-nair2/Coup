import 'dart:async';

import 'package:coup/modals/firebase/fbModels.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/services/global.dart';
import 'package:coup/services/types.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

class TableService<T> {
  final String collection = 'tables';
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  GameTable _table;

  TableService() {
    var ref = _db.reference().child('tables/' + IDManager.tableId);
    ref.onValue.map((event) {
      if (event.snapshot.value != null) {
        _table = GameTable.fromRdb(event.snapshot.value);
        _controller.sink.add(_table);
      }
    });
  }

  final _controller = StreamController<GameTable>();

  Stream<GameTable> get stream => _controller.stream;

  Future<T> getDocument() async {
    SelfPlayer player = await Global.selfRef.getDocument();

    if (player != null) {
      Document doc = Document<T>(path: '$collection/${player.tableId}');
      return doc.getData();
    } else {
      return null;
    }
  }

  Future<void> upsert(Map data) async {
    SelfPlayer player = await Global.selfRef.getDocument();
    Document<T> ref = Document(path: '$collection/${player.tableId}');
    return ref.upsert(data);
  }
}
