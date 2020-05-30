import 'package:coup/components/all_moves.dart';
import 'package:coup/components/play_area.dart';
import 'package:coup/components/self_area.dart';
import 'package:coup/firebase/firedb.dart';
import 'package:coup/modals/chance.dart';
import 'package:coup/modals/game_table.dart';
import 'package:coup/modals/hand.dart';
import 'package:coup/modals/isk.dart';
import 'package:coup/modals/self.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  GameScreen({Key key}) : super(key: key);

  final Hand hand = Hand(['contessa', 'duke']);
  final Isk isk = Isk(0);
  final Chance chance = Chance(0);
  final String tableId = "ymAmWOuxrNYwXxWDg1Mo";
  final FirestoreService db = FirestoreService();
  final SelfPlayer self = SelfPlayer();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Hand>.value(value: hand),
        ChangeNotifierProvider<Isk>.value(value: isk),
        ChangeNotifierProvider<Chance>.value(value: chance),
        StreamProvider<GameTable>.value(
            value: db.tableStream(tableId)) // needs catch error
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
