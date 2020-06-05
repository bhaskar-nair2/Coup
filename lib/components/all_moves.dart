import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:coup/components/action_card.dart';
import 'package:coup/components/roleTile.dart';
import 'package:coup/modals/action.dart';
import 'package:coup/modals/chance.dart';
import 'package:coup/modals/isk.dart';
import 'package:coup/modals/role.dart';
import 'package:coup/modals/self.dart';

class AllMovesList extends StatelessWidget {
  const AllMovesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _player = Provider.of<SelfPlayer>(context);

    // List of all roles
    final roleList = RoleName.values.map((role) => CardRole(role)).toList();

    final List<CardAction> globalActionList =
        CardRole(RoleName.global).actions; // GlobalActions

    List<List<CardAction>> allMoves = roleList
        .where((role) =>
            role.role != RoleName.global && !_player.hand.cards.contains(role))
        .map((e) => e.actions)
        .toList();

    var scrollerHeight = min((allMoves.length + 1) * 0.14, 0.8);

    if (_player != null)
      return SizedBox.expand(
          child: DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.2,
        maxChildSize: scrollerHeight, // ! needs to be dynamic
        builder: (BuildContext context, ScrollController scrollController) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<Chance>.value(value: _player.chance),
                ChangeNotifierProvider<Isk>.value(value: _player.isk)
              ],
              child: MovesHolder(
                globalActionList: globalActionList,
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
    @required this.globalActionList,
    @required this.allMoves,
    @required this.scrollController,
  }) : super(key: key);

  final List<CardAction> globalActionList;
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
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                ...globalActionList.map((move) => ActionCard(move)).toList(),
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
