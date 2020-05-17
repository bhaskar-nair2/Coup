import 'package:coup/components/action_card.dart';
import 'package:coup/modals/action.dart';
import 'package:coup/modals/hand.dart';
import 'package:coup/modals/role.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllMovesList extends StatelessWidget {
  const AllMovesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hand = Provider.of<Hand>(context);
    final roleList = RoleName.values.map((role) => CardRole(role)).toList();

    List<List<CardAction>> allMoves = roleList
        .where((role) => !hand.cards.contains(role))
        .map((e) => e.actions)
        .toList();

    return SizedBox.expand(
        child: DraggableScrollableSheet(
      initialChildSize: 0.08,
      minChildSize: 0.08,
      maxChildSize: 0.6,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.white60,
          child: ListView.builder(
            controller: scrollController,
            itemCount: allMoves.length,
            itemBuilder: (context, index) {
              var moveList = allMoves[index];
              return SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: moveList.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(width: 5),
                  itemBuilder: (context, index) {
                    return ActionCard(moveList[index]);
                  },
                ),
              );
            },
          ),
        );
      },
    ));
  }
}

/*

      */
