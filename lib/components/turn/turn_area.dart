import 'package:coup/components/turn/avail_actions.dart';
import 'package:coup/components/turn/global_actions.dart';
import 'package:coup/modals/game/chance.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/turn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TurnArea extends StatelessWidget {
  const TurnArea({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IDManager.turnId != null
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[GlobalHolder(), ActionHolder()],
            ),
          )
        : SizedBox.shrink();
  }
}

class ActionHolder extends StatelessWidget {
  const ActionHolder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        color: Colors.black26,
        child: AvailableActions(),
      ),
    );
  }
}

class GlobalHolder extends StatelessWidget {
  const GlobalHolder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _turn = Provider.of<Turn>(context);
    var _chance = _turn?.chance ?? Chance(active: false);

    return Align(
      alignment: Alignment.centerRight,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: MediaQuery.of(context).size.width,
        height: _chance.active ? 80 : 0,
        child: GlobalActions(),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
        ),
      ),
    );
  }
}
