import 'package:coup/components/callerDialogs/exchange_dialog.dart';
import 'package:coup/components/roleTile.dart';
import 'package:coup/modals/hand.dart';
import 'package:coup/modals/isk.dart';
import 'package:coup/modals/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CallerFunctions {
  static incomeCall(BuildContext context) {
    final isk = Provider.of<Isk>(context, listen: false);
    isk.increment(1);
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
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Which player would like to Assassinate?"),
            actions: <Widget>[
              FlatButton(onPressed: () => {}, child: Text("Player 1.name")),
              FlatButton(onPressed: () => {}, child: Text("Player 2.name")),
            ],
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
