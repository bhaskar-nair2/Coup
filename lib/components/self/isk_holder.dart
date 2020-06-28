import 'package:coup/firebase/callers.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/game/isk.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class IskHolder extends StatelessWidget {
  IskHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _self = Provider.of<SelfPlayer>(context);

    final isk = _self?.isk ?? Isk(0);

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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            width: 70,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  'assets/paintCardImg/iskImg.png',
                  width: 25,
                  height: 25,
                ),
                SizedBox(
                  width: 25,
                  child: Text(
                    "${isk.counter}",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
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
          )
        ],
      ),
    );
  }
}
