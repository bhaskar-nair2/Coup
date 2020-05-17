import 'package:coup/components/all_moves.dart';
import 'package:coup/components/legal_moves.dart';
import 'package:coup/components/power_card.dart';
import 'package:coup/modals/hand.dart';
import 'package:coup/modals/role.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Hand hand = Hand([CardRole.assassin, CardRole.ambassador]);

  killCard(index) {
    // hand.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "ISK",
                      style: TextStyle(color: Colors.red),
                    ),
                    Row(
                      children:
                          hand.cards.map((e) => PowerCardHolder(e)).toList(),
                    )
                  ],
                ),
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
                        child: LegalMovesList(hand)),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ],
            ),
          ),
          AllMovesList(hand),
        ]),
      ),
    );
  }
}
