import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:coup/firebase/callers.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:flutter/material.dart';

class CreateTableDialog extends StatefulWidget {
  const CreateTableDialog({Key key}) : super(key: key);

  @override
  _CreateTableDialogState createState() => _CreateTableDialogState();
}

class _CreateTableDialogState extends State<CreateTableDialog> {
  var tablePin;
  bool loading = false;
  TextEditingController totalPlayersCtl = TextEditingController(text: '6');

  createTableFn() async {
    bool state = false;
    try {
      toggleLoading();
      await FirebaseCallers.createTable(
        tablePin,
        IDManager.selfId,
        totalPlayersCtl.text,
      );
      await FirebaseCallers.joinTable(
        IDManager.selfId,
        IDManager.tableId,
      );
      state = true;
    } catch (error) {
      state = false;
    } finally {
      toggleLoading();
      ExtendedNavigator.rootNavigator.pop(state);
    }
  }

  String generatePIN() {
    //generate a 4 digit integer 1000 <10000
    var rm = new Random();
    String randomPIN =
        IDManager.selfId.toString().substring(0, 2).toUpperCase() +
            (1000 + rm.nextInt(999)).toString();

    //Store integer in a string
    return randomPIN;
  }

  toggleLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  void initState() {
    super.initState();
    tablePin = generatePIN();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.white70,
      child: Container(
        height: 300,
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Center(
                  child: Text(
                tablePin,
                style: TextStyle(fontSize: 42),
              )),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: totalPlayersCtl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1),
                ),
                labelText: 'Total Players',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FlatButton(
                onPressed: createTableFn,
                child: Text("Create Table"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
