import 'package:coup/components/turn/action_card.dart';
import 'package:coup/data/global_card_actions.dart';
import 'package:flutter/material.dart';

class GlobalActions extends StatelessWidget {
  const GlobalActions({Key key}) : super(key: key);

  static final actionList = GlobalCardActions.list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: List.generate(actionList.length, (index) {
            return SizedBox(
              width: 100,
              height: 80,
              child: ActionCard(actionList[index]),
            );
          })),
    );
  }
}
