import 'package:coup/modals/action.dart';
import 'package:coup/modals/hand.dart';
import 'package:coup/modals/isk.dart';
import 'package:coup/modals/role.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionCard extends StatelessWidget {
  const ActionCard(this.action, {Key key}) : super(key: key);

  final CardAction action;

  @override
  Widget build(BuildContext context) {
    final hand = Provider.of<Hand>(context);
    final isk = Provider.of<Isk>(context);

    return GestureDetector(
      onTap: () => action.caller(hand) ?? print(action),
      child: SizedBox(
        width: 120,
        child: Card(
          color: action.active ? action.role.color : Colors.grey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                    child: Text(
                      action.name,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    action.description,
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
