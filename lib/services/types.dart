import 'package:coup/services/global.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

// NOt used in the project
class Document<T> extends ChangeNotifier {
  final FirebaseDatabase _db = FirebaseDatabase.instance;
  final String path;
  DatabaseReference ref;

  Document({this.path}) {
    ref = _db.reference().child(path);
  }

  Future<T> getData() {
    return ref.once().then((v) => Global.models[T](v.value) as T);
  }

  Stream<T> streamData() {
    return ref.onValue.map((v) => Global.models[T](v.snapshot.value) as T);
  }

  Future<void> upsert(Map data) {
    return ref.update(Map<String, dynamic>.from(data));
  }
}
