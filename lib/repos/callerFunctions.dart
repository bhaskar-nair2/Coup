import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/components/callerDialogs/exchange_dialog.dart';
import 'package:coup/firebase/test.dart';
import 'package:coup/modals/game_table.dart';
import 'package:coup/modals/hand.dart';
import 'package:coup/modals/isk.dart';
import 'package:coup/modals/role.dart';
import 'package:coup/modals/self.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CallerFunctions {
  static incomeCall(BuildContext context) async {
    final table = Provider.of<GameTable>(context, listen: false);
    SelfPlayer self = SelfPlayer();
    // Do this via cloud function
    // await table.ref.get().then((tableData) {
    //   List players = tableData["players"];
    //   var player = players.singleWhere((pl) => pl.id == self.uid);
    //   player["isk"] = player["isk"] + 1;
    //   print(players);
    // });
    // table.ref.setData({});
  }

  static aidCall(BuildContext context) {
    final isk = Provider.of<Isk>(context, listen: false);
    isk.increment(2);
  }

  static coupCall(BuildContext context) {
    final isk = Provider.of<Isk>(context, listen: false);
    isk.decrement(7);
  }

  static assassinateCall(BuildContext context) {
    final isk = Provider.of<Isk>(context, listen: false);
    final table = Provider.of<GameTable>(context, listen: false);

    table.players.map((e) => e.name);

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
    isk.decrement(3);
  }

  static exchangeCall(BuildContext context) {
    final hand = Provider.of<Hand>(context, listen: false);
    List<RoleName> randomRole = [RoleName.assassin, RoleName.ambassador];
    showDialog(
        context: context,
        builder: (context) {
          return ExchangeDialog(roles: randomRole, hand: hand);
        });
  }
}
