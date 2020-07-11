import 'package:coup/components/turn/__basic_card.dart';
import 'package:coup/data/actions/basic_actions.dart';
import 'package:flutter/material.dart';

class GlobalActionsHolder extends StatelessWidget {
  const GlobalActionsHolder({Key key}) : super(key: key);

  static final actionList = BasicActions.list;

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
              child: BasicActionsCard(), //actionList[index]
            );
          })),
    );
  }
}
