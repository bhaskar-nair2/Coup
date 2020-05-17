import 'package:coup/modals/move.dart';
import 'package:flutter/material.dart';

class MoveCard extends StatelessWidget {
  const MoveCard(
    this.move, {
    Key key,
  }) : super(key: key);

  final Move move;

  @override
  Widget build(BuildContext context) {
    var active = true;
    return GestureDetector(
      onTap: () => print(move),
      child: SizedBox(
        width: 120,
        child: Card(
          color: active ? move.type.color : Colors.grey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                    child: Text(
                      move.name,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    move.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 8),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
