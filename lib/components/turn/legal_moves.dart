import 'package:coup/components/turn/action_card.dart';
import 'package:coup/modals/game/hand.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LegalMovesList extends StatelessWidget {
  const LegalMovesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hand = Provider.of<Hand>(context);

    return SizedBox(
      height: 80,
      child: ListView.separated(
        itemCount: hand.actions.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 5),
        itemBuilder: (context, index) {
          return ActionCard(hand.actions[index]);
        },
      ),
    );
  }
}
