import 'package:coup/components/manager/mng_dialog.dart';
import 'package:coup/components/self/self_area.dart';
import 'package:coup/components/table/table_area.dart';
import 'package:coup/components/turn/turn_area.dart';
import 'package:coup/services/firedb.dart';
import 'package:coup/modals/firebase/game_table.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/firebase/turn.dart';
import 'package:coup/services/global.dart';
import 'package:coup/services/table_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key, this.userId, this.tableId}) : super(key: key);

  final String userId;
  final String tableId;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // IDK why this removes the player from the game
    // FirebaseCallers.leaveTable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<SelfPlayer>.value(
          value: Global.selfRef.documentStream,
          catchError: (context, error) {
            print(error);
            return SelfPlayer();
          },
        ),
        StreamProvider<GameTable>.value(
          value: TableService().stream,
        ),
        StreamProvider<Turn>.value(
          value: Global.turnRef.documentStream,
          catchError: (context, error) {
            print(error);
            return Turn();
          },
        )
      ],
      child: GameStateScreenManager(),
    );
  }
}

class GameStateScreenManager extends StatelessWidget {
  const GameStateScreenManager({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseDatabase _db = FirebaseDatabase.instance;
    var tableREf = _db.reference().child('tables/' + IDManager.tableId);

    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<GameTable>(
            stream: tableREf.onValue
                .map((event) => GameTable.fromRdb(event.snapshot.value)),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return Stack(
                  fit: StackFit.expand,
                  children: snapshot.data.state == TableState.play
                      ? [TableArea(), SelfArea(), TurnArea()]
                      : [TableManagerDialog()],
                );
              else
                return Container(
                  child:
                      Center(child: CircularProgressIndicator(strokeWidth: 3)),
                );
            }),
      ),
    );
  }
}
