import 'package:coup/components/all_moves.dart';
import 'package:coup/components/play_area.dart';
import 'package:coup/components/self_area.dart';
import 'package:coup/firebase/firedb.dart';
import 'package:coup/modals/game_table.dart';
import 'package:coup/modals/self.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  GameScreen({Key key, this.userId, this.tableId}) : super(key: key);

  final FirestoreService db = FirestoreService();
  final String userId;
  final String tableId;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<SelfPlayer>.value(
          value: db.selfStream(userId),
          initialData: SelfPlayer(),
          updateShouldNotify: (_, __) => true,
          catchError: (context, error) {
            print("SelfPlayer $error");
            return SelfPlayer();
          },
        ),
        StreamProvider<GameTable>.value(
          value: db.tableStream(tableId),
          initialData: GameTable(),
          updateShouldNotify: (_, __) => true,
          catchError: (context, error) {
            print("GameTableError: $error");
            return GameTable();
          },
        ) // needs catch error
      ],
      child: Scaffold(
        body: Stack(children: [
          PlayArea(),
          SelfArea(),
          AllMovesList(),
        ]),
      ),
    );
  }
}
