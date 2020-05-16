import 'package:flutter/material.dart';

class MoveCard extends StatelessWidget {
  const MoveCard(
    this.moveName, {
    Key key,
    this.active = true,
  }) : super(key: key);

  final moveName;
  final active;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Card(
        color: active ? Colors.blue : Colors.grey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(moveName),
          ),
        ),
      ),
    );
  }
}
