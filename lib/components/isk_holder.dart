import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/modals/isk.dart';
import 'package:coup/modals/self.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IskHolder extends StatelessWidget {
  IskHolder({Key key}) : super(key: key);

  final SelfPlayer self = SelfPlayer();

  @override
  Widget build(BuildContext context) {
    final isk = Provider.of<Isk>(context);

    final HttpsCallable leaveTableFunction = CloudFunctions.instance
        .getHttpsCallable(functionName: 'tableFunctions-leaveTable');

    leaveTable() async {
      var resp = await leaveTableFunction.call(<String, dynamic>{
        'tableId': 'ymAmWOuxrNYwXxWDg1Mo',
        'userId': self.uid,
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
              color: Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(
                'assets/roleLogos/contessa.png',
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
