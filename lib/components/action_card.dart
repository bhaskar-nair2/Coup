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

    if (action.activator != null) action.activator(context);

    return GestureDetector(
      onTap: () =>
          action.active ? action.caller(context) ?? print(action) : () => {},
      child: AspectRatio(
        aspectRatio: 1.8 / 1,
        child: Card(
          color: action.active ? action.role.color : Colors.grey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 25,
                    child: Text(
                      action.name,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    child: Text(
                      action.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 8),
                    ),
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
