import 'package:coup/components/all_moves.dart';
import 'package:coup/components/isk_holder.dart';
import 'package:coup/components/play_area.dart';
import 'package:coup/components/power_card.dart';
import 'package:coup/firebase/auth.dart';
import 'package:coup/firebase/firedb.dart';
import 'package:coup/modals/chance.dart';
import 'package:coup/modals/game_table.dart';
import 'package:coup/modals/hand.dart';
import 'package:coup/modals/isk.dart';
import 'package:coup/modals/role.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  GameScreen({Key key}) : super(key: key);

  final Hand hand =
      Hand([CardRole(RoleName.assassin), CardRole(RoleName.ambassador)]);
  final Isk isk = Isk();
  final Chance chance = Chance(0);
  String tableId = "ymAmWOuxrNYwXxWDg1Mo";
  FirestoreService db = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Hand>.value(value: hand),
        ChangeNotifierProvider<Isk>.value(value: isk),
        ChangeNotifierProvider<Chance>.value(value: chance),
        StreamProvider<GameTable>.value(value: db.tableStream(tableId))
      ],
      child: Scaffold(
        body: SafeArea(
          child: Stack(children: [
            PlayArea(),
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // IskHolder(),
                          PowerCardHolder(),
                          FlatButton(
                            onPressed: () => {AuthService().signOut()},
                            child: Text("Signout"),
                          )
                        ],
                      )),
                ],
              ),
            ),
            AllMovesList(),
          ]),
        ),
      ),
    );
  }
}
