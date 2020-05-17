import 'package:coup/components/move_card.dart';
import 'package:coup/modals/ability.dart';
import 'package:coup/modals/action.dart';
import 'package:coup/modals/hand.dart';
import 'package:coup/modals/move.dart';
import 'package:coup/modals/passive.dart';
import 'package:flutter/material.dart';

class LegalMovesList extends StatelessWidget {
  const LegalMovesList(
    this.hand, {
    Key key,
  }) : super(key: key);

  final Hand hand;

  @override
  Widget build(BuildContext context) {
    List<Move> moves = [
      ...hand.actions.map((e) => e.instance),
      ...hand.abilities.map((e) => e.instance),
      ...hand.passive.map((e) => e.instance)
    ];

    return SizedBox(
      height: 80,
      child: ListView.separated(
        itemCount: moves.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 5),
        itemBuilder: (context, index) {
          return MoveCard(moves[index]);
        },
      ),
    );
  }
}
