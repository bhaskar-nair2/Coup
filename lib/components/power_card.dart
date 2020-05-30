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

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      itemCount: hand.cards.length,
      itemBuilder: (BuildContext cont, index) {
        if (hand == null) return Text("loading");

        final card = hand.cards[index];
        return AspectRatio(
          aspectRatio: 1 / 1.3,
          child: GestureDetector(
            onTap: () {
              print("tap Tap");
              List<CardAction> availActions = card.actions
                  .where((action) => action.active == true)
                  .toList();
              if (availActions.length == 0)
                Fluttertoast.showToast(
                  msg: "No Actions Available",
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 12.0,
                );
              else {
                CardAction action = availActions[0];
                action.caller(context);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image: card.role.cardImage)),
            ),
          ),
        );
      },
    );
  }
}

class AbilityBox extends StatelessWidget {
  const AbilityBox({
    Key key,
    @required this.role,
    this.isActivated = false,
  }) : super(key: key);

  final CardRole role;
  final bool isActivated; // Passive is activated

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: role.actions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              role.actions[index].name,
              style: TextStyle(
                fontSize: 8,
                color:
                    role.actions[index].active ? Colors.white : Colors.white24,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
