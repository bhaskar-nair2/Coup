import 'package:coup/components/turn/__action_card.dart';
import 'package:coup/data/actions/action_enums.dart';
import 'package:coup/data/actions/basic_actions.dart';
import 'package:coup/data/actions/role_abilities.dart';
import 'package:coup/data/actions/role_actions.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/firebase/turn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasicBtnsHolder extends StatelessWidget {
  const BasicBtnsHolder({
    Key key,
  }) : super(key: key);

  static final actionList = BasicActions.list;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: List.generate(actionList.length, (index) {
                return SizedBox(
                  width: 100,
                  height: 80,
                  child: ActionCard(
                    actionList[index],
                    legal: true,
                  ), //actionList[index]
                );
              })),
        ),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
        ),
      ),
    );
  }
}

class ActionHolder extends StatelessWidget {
  const ActionHolder({
    Key key,
  }) : super(key: key);

  static final actionList = RoleActions.list;

  @override
  Widget build(BuildContext context) {
    var player = Provider.of<SelfPlayer>(context);
    var hand = player.hand;

    var legalActions = hand.cards.map((e) => e?.action?.action).toList();

    return Align(
      alignment: Alignment.centerRight,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: MediaQuery.of(context).size.width,
        height: 100,
        color: Colors.black26,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: actionList.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 120,
                  child: ActionCard(
                    actionList[index],
                    legal: legalActions.contains(actionList[index].action),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 10),
            )),
      ),
    );
  }
}

class AbilityHolder extends StatelessWidget {
  const AbilityHolder({Key key, this.passive}) : super(key: key);

  final bool passive;

  @override
  Widget build(BuildContext context) {
    var player = Provider.of<SelfPlayer>(context);
    var turn = Provider.of<Turn>(context);

    var actionList = turn.action.type.blocker;
    bool challengeable = turn.action.type.challengeable;

    if (challengeable) actionList.add(ActionName.challenge);

    var hand = player.hand;
    var legalActions = hand.cards.map((e) => e?.ability?.action).toList();

    if (challengeable) legalActions.add(ActionName.challenge);

    return Align(
      alignment: Alignment.centerRight,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: MediaQuery.of(context).size.width,
        height: 100,
        color: Colors.black26,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: actionList.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 120,
                  child: ActionCard(
                    actionList[index].getAssociatedAction(),
                    legal: legalActions.contains(actionList[index]),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 10),
            )),
      ),
    );
  }
}
