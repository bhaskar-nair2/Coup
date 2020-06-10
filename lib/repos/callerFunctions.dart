import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/components/callerDialogs/exchange_dialog.dart';
import 'package:coup/modals/game_table.dart';
// import 'package:coup/modals/hand.dart'; NONONOONONO
// import 'package:coup/modals/isk.dart'; NONONOONONO
// import 'package:coup/modals/role.dart'; NONONOONONO
import 'package:coup/modals/self.dart';
import 'package:coup/repos/globalFbFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CallerFunctions {
  static final FbFunctions _fbFns =
      FbFunctions(); // maybe move to firebase fns later?
  static final SelfPlayer _self = SelfPlayer();
  static final GameTable _table = GameTable();

  //global

  static incomeCall(BuildContext context) async {
    await _fbFns.addActionTurn({"action": "income", "player": _self.uid});
    Fluttertoast.showToast(msg: "Taking Income");
    await _fbFns.updateIsk(1);
  }

  static aidCall(BuildContext context) async {
    await _fbFns.addActionTurn({"action": "aid", "player": _self.uid});
    Fluttertoast.showToast(msg: "Taking Aid");
    await _fbFns.updateIsk(2);
  }

  static coupCall(BuildContext context) {
    // final isk = Provider.of<Isk>(context, listen: false);
    // isk.decrement(7);
  }

  // role based
  static taxCall(BuildContext context) {
    
  }

  static assassinateCall(BuildContext context) {
    final table = Provider.of<GameTable>(context, listen: false);
    _table.players.map((e) => e.name);
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

  static stealCall(BuildContext context) {
    
  }


}
