import 'package:coup/repos/firebase/gameSetup.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        child: SizedBox(
          height: 20,
          width: 60,
          child: FlatButton(
            splashColor: Colors.cyan,
            color: Colors.blue,
            child: Text("Exit", style: TextStyle()),
            onPressed: leave,
          ),
        ),
      ),
    );
  }
}
