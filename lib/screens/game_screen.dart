// import 'package:coup/components/all_moves.dart';
// import 'package:coup/components/legal_moves.dart';
import 'package:coup/components/all_moves.dart';
import 'package:coup/components/legal_moves.dart';
import 'package:coup/components/power_card.dart';
import 'package:coup/modals/hand.dart';
import 'package:coup/modals/role.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  GameScreen({Key key}) : super(key: key);

  final Hand hand =
      Hand([CardRole(RoleName.assassin), CardRole(RoleName.ambassador)]);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Hand>.value(
      value: hand,
      child: Scaffold(
        body: SafeArea(
          child: Stack(children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "ISK",
                            style: TextStyle(color: Colors.red),
                          ),
                          PowerCardHolder(),
                        ],
                      )),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          border: Border.symmetric(
                            vertical: BorderSide(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        child: LegalMovesList(),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
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
