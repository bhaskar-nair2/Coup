import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/firebase/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class UserPresence {
  static final _app = FirebaseApp.instance;
  static final FirebaseDatabase _db = FirebaseDatabase(
    app: _app,
    databaseURL: 'https://coup-dc26b.firebaseio.com/',
  );

  static rtdbAndLocalFsPresence(app) async {
    var uid = (await AuthService().getUser).uid;
    var userStatusDatabaseRef = _db.reference().child('/status/' + uid);
    var userStatusFirestoreRef =
        Firestore.instance.collection('status').document(uid);

    var isOfflineForDatabase = {
      "state": 'offline',
      "last_changed": ServerValue.timestamp,
    };

    var isOnlineForDatabase = {
      "state": 'online',
      "last_changed": ServerValue.timestamp,
    };

    // Firestore uses a different server timestamp value, so we'll
    // create two more constants for Firestore state.
    var isOfflineForFirestore = {
      "state": 'offline',
      "last_changed": FieldValue.serverTimestamp(),
    };

    var isOnlineForFirestore = {
      "state": 'online',
      "last_changed": FieldValue.serverTimestamp(),
    };

    _db
        .reference()
        .child('.info/connected')
        .onValue
        .listen((Event event) async {
      if (event.snapshot.value == false) {
        // Instead of simply returning, we'll also set Firestore's state
        // to 'offline'. This ensures that our Firestore cache is aware
        // of the switch to 'offline.'
        userStatusFirestoreRef.updateData(isOfflineForFirestore);
        return;
      }

      await userStatusDatabaseRef
          .onDisconnect()
          .update(isOfflineForDatabase)
          .then((snap) {
        userStatusDatabaseRef.set(isOnlineForDatabase);

        // We'll also add Firestore set here for when we come online.
        userStatusFirestoreRef.updateData(isOnlineForFirestore);
      });
    });
  
  }
}
