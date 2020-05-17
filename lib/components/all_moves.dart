import 'package:coup/modals/hand.dart';
import 'package:coup/modals/move.dart';
import 'package:flutter/material.dart';
import 'package:coup/components/move_card.dart';

class AllMovesList extends StatefulWidget {
  const AllMovesList(this.hand, {Key key}) : super(key: key);

  final Hand hand;

  @override
  _AllMovesListState createState() => _AllMovesListState();
}

class _AllMovesListState extends State<AllMovesList> {
  @override
  Widget build(BuildContext context) {
    List<List<Move>> allMoves = [
      abilityMoves
          .where((ability) => !widget.hand.abilities.contains(ability))
          .map((e) => e)
          .toList()
    ];
    return SizedBox.expand(
        child: DraggableScrollableSheet(
      initialChildSize: 0.05,
      minChildSize: 0.05,
      maxChildSize: 0.4,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.white54,
          child: ListView.builder(
            controller: scrollController,
            itemCount: 1,
            itemBuilder: (context, index) {
              var moveList = allMoves[index];
              return SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: moveList.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(width: 5),
                  itemBuilder: (context, index) {
                    return MoveCard(moveList[index]);
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
