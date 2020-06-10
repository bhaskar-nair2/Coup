import 'package:coup/modals/action.dart';
import 'package:coup/modals/hand.dart';
import 'package:coup/modals/role.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PowerCardHolder extends StatelessWidget {
  const PowerCardHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hand = Provider.of<Hand>(context);

    return Row(
      children: List.generate(
        hand.cards.length,
        (index) => PowerCard(
          card: hand.cards[index],
          index: index,
          single: hand.cards.length == 1,
        ),
      ),
    );
  }
}

class PowerCard extends StatelessWidget {
  const PowerCard(
      {Key key, @required this.card, @required this.index, this.single = false})
      : super(key: key);

  final CardRole card;
  final int index;
  final bool single;

  double rotateAngle(index) {
    if (single) return 0;
    if (index % 2 == 0)
      return -15;
    else
      return 15;
  }

  doAction(card, context) {
    print("tap Tap");
    List<CardAction> availActions =
        card.actions.where((action) => action.active == true).toList();
    if (availActions.length == 0) {
      Fluttertoast.showToast(
        msg: "No Actions Available",
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    } else {
      CardAction action = availActions[0];
      action.caller(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        doAction(card, context);
      },
      child: Transform.rotate(
        angle: 3.14 / rotateAngle(index),
        child: Container(
          width: 190,
          height: 320,
          decoration: BoxDecoration(
            image: DecorationImage(image: card.role.cardImage),
          ),
        ),
      ),
    );
  }
}
