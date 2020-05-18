import 'dart:math';

import 'package:coup/components/action_card.dart';
import 'package:coup/components/roleTile.dart';
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

    List<CardAction> utilActions = CardRole(RoleName.global).actions;

    List<List<CardAction>> allMoves = roleList
        .where((role) =>
            role.role != RoleName.global && !hand.cards.contains(role))
        .map((e) => e.actions)
        .toList();

    var scrollerHeight = min((allMoves.length + 1) * 0.14, 0.8);

    return SizedBox.expand(
        child: DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: scrollerHeight,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.white24,
          child: ListView(
            shrinkWrap: true,
            controller: scrollController,
            children: <Widget>[
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ...utilActions.map((move) => ActionCard(move)).toList(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 8),
                child: Text(
                  "All Moves",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...allMoves
                  .map(
                    (moveList) => SizedBox(
                      height: 80,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          RoleTile(moveList[0]),
                          ...moveList.map((move) => ActionCard(move))
                        ],
                      ),
                    ),
                  )
                  .toList()
            ],
          ),
        );
      },
    ));
  }
}
