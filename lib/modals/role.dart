import 'package:coup/style.dart';
import 'package:flutter/material.dart';

import 'package:coup/modals/action.dart';

class CardRole {
  RoleName role;
  String name;
  List<CardAction> actions;

  CardRole(this.role) {
    switch (this.role) {
      case RoleName.duke:
        this.name = "Duke";
        this.actions = [
          CardAction(ActionName.tax, this.role),
          CardAction(ActionName.blockAid, this.role)
        ];
        break;

      case RoleName.contessa:
        this.name = "Contessa";
        this.actions = [
          CardAction(ActionName.blockAssassin, this.role),
          CardAction(ActionName.treaty, this.role)
        ];
        break;

      case RoleName.assassin:
        this.name = "Assassin";
        this.actions = [
          CardAction(ActionName.assassinate, this.role),
          CardAction(ActionName.vengence, this.role)
        ];
        break;

      case RoleName.ambassador:
        this.name = "Ambassador";
        this.actions = [
          CardAction(ActionName.exchange, this.role),
          CardAction(ActionName.limitSteal, this.role),
          CardAction(ActionName.inheritance, this.role)
        ];
        break;

      case RoleName.captain:
        this.name = "Captain";
        this.actions = [
          CardAction(ActionName.steal, this.role),
          CardAction(ActionName.blockSteal, this.role)
        ];
        break;
    }
  }

  @override
  bool operator ==(covariant CardRole other) => other.role == role;
  @override
  int get hashCode => super.hashCode;
}

enum RoleName { duke, contessa, assassin, ambassador, captain }

extension RoleColorExtention on RoleName {
  Color get color {
    switch (this) {
      case RoleName.duke:
        return CoupColors.duke;
        break;
      case RoleName.contessa:
        return CoupColors.contessa;
        break;
      case RoleName.assassin:
        return CoupColors.assassin;
        break;
      case RoleName.ambassador:
        return CoupColors.ambassador;
        break;
      case RoleName.captain:
        return CoupColors.captain;
        break;
      default:
        return Colors.black;
    }
  }
}
