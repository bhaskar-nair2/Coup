// import 'package:coup/components/self/self_area.dart';
import 'package:coup/components/table/table_area.dart';
// import 'package:coup/components/turn/turn.dart';
import 'package:coup/firebase/firedb.dart';
import 'package:coup/modals/firebase/game_table.dart';
// import 'package:coup/modals/firebase/self.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  GameScreen({Key key, this.userId, this.tableId}) : super(key: key);

  final String userId;
  final String tableId;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<GameTable>.value(
          value: FirestoreService.tableStream(tableId),
          catchError: (context, error) {
            print(error);
            return GameTable();
          },
        ),
        // ChangeNotifierProvider<SelfPlayer>.value(value: _self),
      ],
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              TableArea(),
              // SelfArea(),
              // TurnArea(),
            ],
          ),
        ),
      ),
    );
  }
}
