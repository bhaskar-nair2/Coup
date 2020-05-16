import 'package:coup/components/move_card.dart';
import 'package:coup/components/power_card.dart';
import 'package:coup/modals/role.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<CardRole> hand = [CardRole.contessa, CardRole.ambassador];

  killCard(index) {
    hand.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Coins",
                    style: TextStyle(color: Colors.red),
                  ),
                  Row(
                    children: hand.map((e) => PowerCardHolder(e)).toList(),
                  )
                ],
              ),
              Wrap(
                children: <Widget>[
                  AvailMovesList(),
                  AllMovesList(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AllMovesList extends StatelessWidget {
  const AllMovesList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 5),
        itemBuilder: (context, index) {
          return MoveCard(
            'Move $index',
            active: index % 3 == 0,
          );
        },
      ),
    );
  }
}

class AvailMovesList extends StatelessWidget {
  const AvailMovesList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 5),
        itemBuilder: (context, index) {
          return MoveCard(
            'Move $index',
            active: index % 3 == 0,
          );
        },
      ),
    );
  }
}
