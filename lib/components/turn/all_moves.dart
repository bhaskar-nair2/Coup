import 'dart:math';

import 'package:coup/components/turn/action_card.dart';
import 'package:coup/components/turn/roleTile.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/game/action.dart';
import 'package:coup/modals/game/isk.dart';
import 'package:coup/modals/game/role.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AllMovesList extends StatelessWidget {
  const AllMovesList({Key key}) : super(key: key);

  static final SelfPlayer _self = SelfPlayer();

  @override
  Widget build(BuildContext context) {
    // List of all roles
    final roleList = RoleName.values.map((role) => CardRole(role)).toList();

    List<List<CardAction>> allMoves = roleList
        .where((role) => !_self.hand.cards.contains(role))
        .map((e) => e.actions)
        .toList();

    var scrollerHeight = min((allMoves.length + 1) * 0.14, 0.8);

    if (_self != null)
      return SizedBox.expand(
          child: DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.2,
        maxChildSize: scrollerHeight, // ! needs to be dynamic
        builder: (BuildContext context, ScrollController scrollController) {
          return MultiProvider(
              providers: [ChangeNotifierProvider<Isk>.value(value: _self.isk)],
              child: MovesHolder(
                allMoves: allMoves,
                scrollController: scrollController,
              ));
        },
      ));
    else
      return Text(
        "Loading",
        style: TextStyle(color: Colors.black87),
      );
  }
}

class MovesHolder extends StatelessWidget {
  MovesHolder({
    Key key,
    @required this.allMoves,
    @required this.scrollController,
  }) : super(key: key);

  final List<List<CardAction>> allMoves;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white24,
      child: ListView(
        shrinkWrap: true,
        controller: scrollController,
        children: <Widget>[
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
          if (allMoves != null)
            ...allMoves.map(
              (moveList) => TileRow(moveList),
            )
        ],
      ),
    );
  }
}

class TileRow extends StatelessWidget {
  const TileRow(this.moveList, {Key key}) : super(key: key);

  final List moveList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          RoleTile(moveList[0].role),
          ...moveList.map((move) => ActionCard(move))
        ],
      ),
    );
  }
}
