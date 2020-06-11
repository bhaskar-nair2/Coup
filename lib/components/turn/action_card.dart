import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/game/action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionCard extends StatelessWidget {
  const ActionCard(this.action, {Key key}) : super(key: key);

  final CardAction action;

  @override
  Widget build(BuildContext context) {
    // used to rebuild widget for update
    var _self = Provider.of<SelfPlayer>(context);

    if (action.activator != null) {
      action.active = action.activator(context);
    }

    return GestureDetector(
      onTap: () => action.active == true
          ? action.caller(context) ?? print(action)
          : () => {},
      child: Card(
        color: action.active == true ? Colors.blue : Colors.grey,
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
    );
  }
}
