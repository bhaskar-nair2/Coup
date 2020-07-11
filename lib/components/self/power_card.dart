import 'package:coup/data/role/role_enum.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/game/actions.dart';
import 'package:coup/modals/game/hand.dart';
import 'package:coup/modals/game/role.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PowerCardHolder extends StatelessWidget {
  const PowerCardHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _self = Provider.of<SelfPlayer>(context);
    final Hand hand = _self?.hand ?? Hand();
    bool single = hand.cards.length == 1;
    double botPos = MediaQuery.of(context).size.height * 0.1;

    return Positioned.directional(
      textDirection: TextDirection.ltr,
      bottom: botPos,
      start: single ? (MediaQuery.of(context).size.width - 180) / 4 : 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: List.generate(
            hand.cards.length,
            (index) => PowerCard(
              card: hand.cards[index],
              index: index,
              single: single,
            ),
          ),
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
      return -3.14 / 15;
    else
      return 3.14 / 15;
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
    double cardWidth = MediaQuery.of(context).size.width / 2 - 20;

    return GestureDetector(
      onTap: () {
        if (card.role != null) doAction(card, context);
      },
      child: Transform.rotate(
        angle: rotateAngle(index),
        child: Opacity(
          opacity: 1,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 10),
            width: cardWidth,
            height: cardWidth / 0.54,
            decoration: card.role != null
                ? BoxDecoration(
                    image: DecorationImage(image: card.role.cardImage),
                  )
                : BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
            child: card.role == null
                ? Center(
                    child: Text('Loading..'),
                  )
                : SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
