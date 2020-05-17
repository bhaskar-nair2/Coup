import 'package:coup/style.dart';
import 'package:flutter/material.dart';

import 'package:coup/modals/action.dart';

enum RoleName { duke, contessa, assassin, ambassador, captain }

class CardRole {
  RoleName role;
  String name;
  Color color;
  List<CardAction> actions;

  CardRole(this.role) {
    switch (this.role) {
      case RoleName.duke:
        this.name = "Duke";
        this.color = CoupColors.duke;
        this.actions = [CardAction(ActionName.tax)];
        break;

      case RoleName.contessa:
        this.name = "Contessa";
        this.color = CoupColors.contessa;
        this.actions = [
          CardAction(ActionName.blockAssassin),
          CardAction(ActionName.treaty)
        ];
        break;

      case RoleName.assassin:
        this.name = "Assassin";
        this.color = CoupColors.assassin;
        this.actions = [
          CardAction(ActionName.assassinate),
          CardAction(ActionName.vengence)
        ];
        break;

      case RoleName.ambassador:
        this.name = "Ambassador";
        this.color = CoupColors.ambassador;
        this.actions = [
          CardAction(ActionName.exchange),
          CardAction(ActionName.limitSteal),
          CardAction(ActionName.inheritance)
        ];
        break;

      case RoleName.captain:
        this.name = "Captain";
        this.color = CoupColors.captain;
        this.actions = [
          CardAction(ActionName.steal),
          CardAction(ActionName.blockSteal)
        ];
        break;
    }
  }
}
