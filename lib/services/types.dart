import 'package:coup/services/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

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

class UserData<T> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String collection;

  UserData({this.collection});

  Stream<T> get documentStream {
    return _auth.onAuthStateChanged.switchMap((user) {
      if (user != null) {
        Document<T> doc = Document<T>(path: '$collection/${user.uid}');
        return doc.streamData();
      } else {
        return null;
      }
    }); //.shareReplay(maxSize: 1).doOnData((d) => print('777 $d'));// as Stream<T>;
  }

  Future<T> getDocument() async {
    FirebaseUser user = await _auth.currentUser();

    if (user != null) {
      Document doc = Document<T>(path: '$collection/${user.uid}');
      return doc.getData();
    } else {
      return null;
    }
  }

  Future<void> upsert(Map data) async {
    FirebaseUser user = await _auth.currentUser();
    Document<T> ref = Document(path: '$collection/${user.uid}');
    return ref.upsert(data);
  }
}
