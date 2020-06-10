import 'package:coup/components/self/self_area.dart';
import 'package:coup/components/table/play_area.dart';
import 'package:coup/components/turn/all_moves.dart';
import 'package:coup/firebase/firedb.dart';
import 'package:coup/modals/game_table.dart';
import 'package:coup/modals/self.dart';
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
  GameTable _table = GameTable();
  SelfPlayer _self = SelfPlayer();

  @override
  void initState() {
    SelfPlayer.startStream(widget.userId);
    GameTable.startStream(widget.tableId);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GameTable>.value(value: _table),
        ChangeNotifierProvider<SelfPlayer>.value(value: _self),
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
