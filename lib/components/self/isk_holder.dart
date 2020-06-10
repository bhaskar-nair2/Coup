import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/game/isk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IskHolder extends StatelessWidget {
  IskHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _self = Provider.of<SelfPlayer>(context);
    final isk = _self.isk;

    final HttpsCallable leaveTableFunction = CloudFunctions.instance
        .getHttpsCallable(functionName: 'tableFunctions-leaveTable');

    leaveTable() async {
      var resp = await leaveTableFunction.call(<String, dynamic>{
        'tableId': 'ymAmWOuxrNYwXxWDg1Mo',
        'userId': _self.uid,
      });
      print('$resp');
      Navigator.of(context).pushReplacementNamed('/home-screen');
    }

    return Column(
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
            onPressed: leaveTable,
          ),
        )
      ],
    );
  }
}
