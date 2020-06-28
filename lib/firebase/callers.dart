import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirebaseCallers {
  static final _db = FirebaseDatabase.instance;

  static Future createTable(
    String tablePin,
    String userId,
    String total,
  ) async {
    var user = _db.reference().child('players/$userId');
    var table = _db.reference().child('tables').push();
    var turn = _db.reference().child('turns').push();

    await table.set({
      "pin": tablePin.toString(),
      "owner": user.key.toString(),
      "isOpen": true,
      "inProgress": false,
      "limit": int.parse(total),
      "state": 'waiting',
      "turn": turn.key.toString()
    });

    await user.update({"table": table.key.toString()});

    IDManager.turnId = turn.key;
    IDManager.tableId = table.key;
    return;
  }

  static joinTable(String userId, String tableId) async {
    final HttpsCallable _joinFnCallable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'tableFunctions-joinTable');
    await _joinFnCallable.call({
      'tableId': tableId,
      'userId': userId,
    });
  }

  static joinTableWithId(String userId, String tablePin) async {
    var snap =
        await _db.reference().child('tables').equalTo({"pin": tablePin}).once();

    if (snap.value.length > 0) {
      var tableRef = snap.value[0];
      IDManager.tableId = tableRef.documentID;
      IDManager.turnId =
          (tableRef.data['turn'] as DocumentReference).documentID;
      return await joinTable(userId, tableRef.documentID);
    } else {
      throw ErrorWidget.withDetails(message: 'No such Table');
    }
  }

  static startGame(tableId) async {
    final HttpsCallable startGameFunction = CloudFunctions.instance
        .getHttpsCallable(functionName: 'tableFunctions-startGame');
    await startGameFunction.call({"tableId": tableId});
  }

  static leaveTable(String userId, String tableId) async {
    final HttpsCallable leaveTableFunction = CloudFunctions.instance
        .getHttpsCallable(functionName: 'tableFunctions-leaveTable');
    try {
      await leaveTableFunction.call(<String, dynamic>{
        'tableId': tableId,
        'userId': userId,
      });
    } catch (error) {
      print("Start Game Error: $error");
    }
  }
}

// final HttpsCallable leaveTableFunction = CloudFunctions.instance
// .getHttpsCallable(functionName: 'tableFunctions-leaveTable');
