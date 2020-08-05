import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/repos/firebase/game_setup.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PauseMenu extends StatelessWidget {
  const PauseMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    leave() async {
      Fluttertoast.showToast(
        msg: "Leaving Table",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.green,
        fontSize: 12.0,
      );
      await FirebaseCallers.leaveTable();
      Navigator.of(context).pushReplacementNamed('/home-screen');
    }

    return Align(
      alignment: FractionalOffset.topRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'player: ${IDManager.selfId}' ?? '',
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              'table: ${IDManager.tableId}' ?? '',
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              'turn: ${IDManager.turnId}' ?? '',
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: FlatButton(
                splashColor: Colors.cyan,
                color: Colors.blue,
                child: Text("Exit", style: TextStyle()),
                onPressed: leave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
