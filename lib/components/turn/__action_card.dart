import 'package:coup/components/base/base_act_card.dart';
import 'package:coup/modals/firebase/fbModels.dart';
import 'package:coup/modals/game/actions.dart';
import 'package:coup/repos/firebase/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionCard extends StatelessWidget {
  const ActionCard(this.action, {Key key}) : super(key: key);

  final CardAction action;

  @override
  Widget build(BuildContext context) {
    // used to rebuild widget for update
    var turn = Provider.of<Turn>(context);

    if (action.activator != null) {
      action.active = action.activator(context);
    }

    return GestureDetector(
        onTap: () => action.active == true
            ? FirebaseCommons.addTurn(action.toMap()) ?? print(action)
            : () => {},
        child: BaseActCard(
          active: action.active,
          description: action.description,
          name: action.name,
          call: FirebaseCommons.addTurn(action.toMap()),
        ));
  }
}
