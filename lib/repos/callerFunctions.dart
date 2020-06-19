import 'package:coup/firebase/actions.dart';
import 'package:coup/modals/firebase/game_table.dart';
import 'package:coup/modals/game/actionData/global_card_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CallerFunctions {
  static incomeCall(BuildContext context) async {
    Fluttertoast.showToast(msg: "Taking Income");
    await FbTurnFunctions.addActionTurn(GlobalCardActions.income.toMap());
    await FbTurnFunctions.updateIsk(1);
  }

  static aidCall(BuildContext context) async {
    Fluttertoast.showToast(msg: "Taking Aid");
    await FbTurnFunctions.addActionTurn(GlobalCardActions.aid.toMap());
    await FbTurnFunctions.updateIsk(2);
  }

  static coupCall(BuildContext context) {
    // final isk = Provider.of<Isk>(context, listen: false);
    // isk.decrement(7);
  }

  // role based
  static taxCall(BuildContext context) {}

  static assassinateCall(BuildContext context) {
    final table = Provider.of<GameTable>(context, listen: false);
    // _table.players.map((e) => e.name);
    // show all players
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Choose your target"),
            children: <Widget>[
              ...table.players.map((player) => FlatButton(
                  onPressed: () => {},
                  child: Text(
                    player.nick,
                    style: TextStyle(color: Colors.white),
                  ))),
            ],
            backgroundColor: Theme.of(context).primaryColorDark,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        });
    // isk.decrement(3);
  }

  static exchangeCall(BuildContext context) {
    // final hand = Provider.of<Hand>(context, listen: false);
    // List<RoleName> randomRole = [RoleName.assassin, RoleName.ambassador];
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return ExchangeDialog(roles: randomRole, hand: hand);
    //     });
  }

  static stealCall(BuildContext context) {}
}
