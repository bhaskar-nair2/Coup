import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseCallers {
  static joinTable(String userId, String tableId) async {
    final HttpsCallable _joinFnCallable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'tableFunctions-joinTable');
    try {
      Fluttertoast.showToast(
        msg: "Joining Table",
        gravity: ToastGravity.BOTTOM,
        fontSize: 12.0,
      );
      await _joinFnCallable.call(<String, dynamic>{
        'tableId': 'ymAmWOuxrNYwXxWDg1Mo',
        'userId': userId,
      });
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error Joining Table $error",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.red,
        fontSize: 12.0,
      );
    }
  }
}

// final HttpsCallable leaveTableFunction = CloudFunctions.instance
      // .getHttpsCallable(functionName: 'tableFunctions-leaveTable');
