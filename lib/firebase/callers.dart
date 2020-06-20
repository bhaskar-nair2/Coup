import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseCallers {
  static final _db = Firestore.instance;

  static Future createTable(
    String tablePin,
    String userId,
    String total,
  ) async {
    try {
      var user = _db.collection('players').document(userId);
      var table = _db.collection('tables').document(userId);
      var turn = _db.collection('turns').document(userId);

      await table.setData({
        "pin": tablePin,
        "owner": user,
        "isOpen": true,
        "inProgress": false,
        "limit": int.parse(total),
        "players": [],
        "state": 'waiting',
        "turn": turn
      });

      await user.setData({"table": table}, merge: true);

      IDManager.turnId = turn.documentID;
      IDManager.tableId = table.documentID;
    } catch (error) {
      print("createTable: $error");
      Fluttertoast.showToast(
          msg: "Error Creating Table $error", textColor: Colors.red);
      return '';
    }
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
    var snap = await _db
        .collection('tables')
        .where('pin', isEqualTo: tablePin)
        .limit(1)
        .getDocuments();

    if (snap.documents.length > 0) {
      var tableRef = snap.documents[0];
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
      Fluttertoast.showToast(
        msg: "Error leaving Table $error",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.red,
        fontSize: 12.0,
      );
    }
  }
}

// final HttpsCallable leaveTableFunction = CloudFunctions.instance
// .getHttpsCallable(functionName: 'tableFunctions-leaveTable');
