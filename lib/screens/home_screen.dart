import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/modals/self.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);
  final SelfPlayer self = SelfPlayer();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SelfPlayer>.value(value: self),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.deepPurple,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Coup",
                    style: TextStyle(
                      fontSize: 82,
                      fontWeight: FontWeight.w800,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  Text('"the game"'),
                  SizedBox(height: 30),
                  OptionButtons()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OptionButtons extends StatefulWidget {
  OptionButtons({Key key}) : super(key: key);

  @override
  _OptionButtonsState createState() => _OptionButtonsState();
}

class _OptionButtonsState extends State<OptionButtons> {
  SelfPlayer self = SelfPlayer();

  final HttpsCallable joinTableFunction =
      CloudFunctions.instance.getHttpsCallable(
    functionName: 'tableFunctions-joinTable',
  );

  joinTable() async {
    var resp = await joinTableFunction.call(<String, dynamic>{
      'tableId': 'ymAmWOuxrNYwXxWDg1Mo',
      'userId': self.uid,
    });
    print('$resp');
    Navigator.of(context).pushNamed('/game-screen');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          FlatButton(
            onPressed: joinTable,
            child: Text("Join a Table"),
          ),
          FlatButton(
            onPressed: () => {},
            child: Text("Create new Table"),
          )
        ],
      ),
    );
  }
}
