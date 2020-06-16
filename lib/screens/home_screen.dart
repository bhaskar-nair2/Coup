import 'package:auto_route/auto_route.dart';
import 'package:coup/components/table/createTableDialog.dart';
import 'package:coup/components/table/joinTableDialog.dart';
import 'package:coup/components/table/logoutBtn.dart';
import 'package:coup/firebase/auth.dart';
import 'package:coup/firebase/callers.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/router/router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:coup/firebase/firedb.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  final db = FirestoreService();
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<FirebaseUser>.value(value: _authService.user),
      ],
      child: Scaffold(
        body: Stack(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/paintCardImg/base.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          OptionButtons()
        ]),
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
  @override
  Widget build(BuildContext context) {
    return Positioned.directional(
      textDirection: TextDirection.ltr,
      bottom: 20,
      start: 10,
      child: SizedBox(
        height: 200,
        width: 200,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green.withOpacity(0.3),
              ),
              child: FlatButton(
                onPressed: () async {
                  var resp = await showDialog(
                    context: context,
                    builder: (context) => JoinTableDialog(),
                  );
                  if (resp == true)
                    ExtendedNavigator.rootNavigator.pushReplacementNamed(
                      '/game-screen',
                      arguments: GameScreenArguments(
                        tableId: IDManager.tableId,
                        userId: IDManager.selfId,
                      ),
                    );
                  else
                    Fluttertoast.showToast(
                      msg: 'No Such Table',
                      backgroundColor: Colors.redAccent,
                    );
                },
                child: Text("Join a Table"),
              ),
            ),
            FlatButton(
              onPressed: () async {
                var resp = await showDialog(
                  context: context,
                  builder: (context) => CreateTableDialog(),
                );
                if (resp == true)
                  ExtendedNavigator.rootNavigator.pushReplacementNamed(
                    '/game-screen',
                    arguments: GameScreenArguments(
                      tableId: IDManager.tableId,
                      userId: IDManager.selfId,
                    ),
                  );
                else
                  Fluttertoast.showToast(
                    msg: 'Table Creation Failed',
                    backgroundColor: Colors.redAccent,
                  );
              },
              child: Text("Create new Table"),
            ),
            LogoutBtn(),
          ],
        ),
      ),
    );
  }
}
