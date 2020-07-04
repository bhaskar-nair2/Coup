import 'package:coup/components/manager/mng_dialog.dart';
import 'package:coup/components/self/self_area.dart';
import 'package:coup/components/table/table_area.dart';
import 'package:coup/components/turn/turn_area.dart';
import 'package:coup/services/firedb.dart';
import 'package:coup/modals/firebase/game_table.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/firebase/turn.dart';
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
  void dispose() {
    // IDK why this removes the player from the game
    // FirebaseCallers.leaveTable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<GameTable>.value(
          value: FireDB.tableStream(widget.tableId),
          catchError: (context, error) {
            print(error);
            return GameTable();
          },
        ),
        StreamProvider<SelfPlayer>.value(
          value: FireDB.selfStream(widget.userId),
          catchError: (context, error) {
            print(error);
            return SelfPlayer();
          },
        ),
        StreamProvider<Turn>.value(
          value: FireDB.turnStream(IDManager.turnId),
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
    var table = Provider.of<GameTable>(context);
    var turn = Provider.of<Turn>(context);

    return SafeArea(
      child: Scaffold(
        body: table != null && turn != null
            ? Stack(
                fit: StackFit.expand,
                children: table.state == TableState.play
                    ? [
                        TableArea(),
                        SelfArea(),
                        TurnArea(),
                      ]
                    : [
                        TableManagerDialog(),
                      ])
            : Container(
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
              ),
      ),
    );
  }
}
