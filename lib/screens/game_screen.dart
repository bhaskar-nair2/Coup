// import 'package:coup/components/all_moves.dart';
// import 'package:coup/components/legal_moves.dart';
import 'package:coup/components/all_moves.dart';
import 'package:coup/components/isk_holder.dart';
import 'package:coup/components/legal_moves.dart';
import 'package:coup/components/power_card.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Hand>.value(value: hand),
        ChangeNotifierProvider.value(value: isk)
      ],
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
                          IskHolder(),
                          PowerCardHolder(),
                        ],
                      )),
                  Column(
                    children: <Widget>[
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.blueGrey,
                      //     border: Border.symmetric(
                      //       vertical: BorderSide(
                      //         color: Colors.black54,
                      //       ),
                      //     ),
                      //   ),
                      //   child: LegalMovesList(),
                      // ),
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
