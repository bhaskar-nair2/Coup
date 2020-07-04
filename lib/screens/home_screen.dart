import 'package:auto_route/auto_route.dart';
import 'package:coup/components/table/createTableDialog.dart';
import 'package:coup/components/table/joinTableDialog.dart';
import 'package:coup/components/table/logoutBtn.dart';
import 'package:coup/firebase/auth.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/router/router.gr.dart';
import 'package:coup/services/firedb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: _auth.user),
        StreamProvider<SelfPlayer>.value(
            value: FireDB.selfStream(IDManager.selfId))
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
    var player = Provider.of<SelfPlayer>(context);

    if (player?.tableId != null) {
      IDManager.tableId = player.tableId;
      Navigator.of(context).pushReplacementNamed('/game-screen',
          arguments: GameScreenArguments(
            tableId: IDManager.tableId,
            userId: IDManager.selfId,
          ));
    }

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
