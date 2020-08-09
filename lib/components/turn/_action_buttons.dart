import 'package:coup/components/turn/__action_card.dart';
import 'package:coup/data/actions/action_enums.dart';
import 'package:coup/data/actions/basic_actions.dart';
import 'package:coup/data/actions/role_actions.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/firebase/turn.dart';
import 'package:coup/modals/game/hand.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonSet {
  static List<Widget> getCurrentButtons(context) {
    var _self = Provider.of<SelfPlayer>(context);
    var _turn = Provider.of<Turn>(context);

    GameState state = _turn?.gameState;
    var chance = _turn?.chance;
    Hand hand = _self?.hand;

    if (state == GameState.play && chance.active == true)
      return [BasicBtnsHolder(), ActionHolder()];
    else if (state == GameState.counter && chance.active == false)
      return [AbilityHolder()];
    else if (state == GameState.block && chance.active == true)
      return [AbilityHolder(challengeOnly: true)]; // passive holder
    else
      return [];
  }
}

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
  const AbilityHolder({Key key, this.passive, this.challengeOnly = false})
      : super(key: key);

  final bool passive;
  final bool challengeOnly;

  @override
  Widget build(BuildContext context) {
    var player = Provider.of<SelfPlayer>(context);
    var turn = Provider.of<Turn>(context);

    List<ActionName> actionList = [];

    if (challengeOnly == false) actionList.addAll(turn.action.type.blocker);
    bool challengeable = turn.action.type.challengeable || false;

    if (challengeable || challengeOnly) actionList.add(ActionName.challenge);

    var hand = player.hand;
    var legalActions = hand.cards.map((e) => e?.ability?.action).toList();

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
