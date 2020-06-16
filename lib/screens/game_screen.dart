import 'package:coup/components/self/self_area.dart';
import 'package:coup/components/table/table_area.dart';
import 'package:coup/components/turn/turn_area.dart';
import 'package:coup/firebase/callers.dart';
import 'package:coup/firebase/firedb.dart';
import 'package:coup/modals/firebase/game_table.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/self.dart';
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
    FirebaseCallers.leaveTable(IDManager.selfId, IDManager.tableId);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<GameTable>.value(
          value: FirestoreService.tableStream(widget.tableId),
          catchError: (context, error) {
            print(error);
            return GameTable();
          },
        ),
        StreamProvider<SelfPlayer>.value(
          value: FirestoreService.selfStream(widget.userId),
          catchError: (context, error) {
            print(error);
            return SelfPlayer();
          },
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              TableArea(),
              SelfArea(),
              TurnArea(),
            ],
          ),
        ),
      ),
    );
  }
}
