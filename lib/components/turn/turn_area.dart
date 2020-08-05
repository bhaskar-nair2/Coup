import 'package:coup/components/turn/_action_buttons.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/firebase/turn.dart';
import 'package:coup/modals/game/hand.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TurnArea extends StatelessWidget {
  const TurnArea({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _turn = Provider.of<Turn>(context);
    var _self = Provider.of<SelfPlayer>(context);

    GameState state = _turn?.gameState;
    var chance = _turn?.chance;
    Hand hand = _self?.hand;

    List<Widget> getComps(state, chance) {
      if (state == GameState.play && chance.active == true)
        return [BasicBtnsHolder(), ActionHolder()];
      else if (state == GameState.counter && chance.active == false)
        return [AbilityHolder()];
      else if (hand?.state == PlayState.one)
        return []; // passive holder
      else
        return [];
    }

    return IDManager.turnId != null
        ? AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: getComps(state, chance)),
          )
        : SizedBox.shrink();
  }
}
