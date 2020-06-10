import 'package:coup/style.dart';
import 'package:flutter/material.dart';

import 'package:coup/modals/action.dart';

class CardRole {
  RoleName role;
  String name;
  List<CardAction> actions;

  @override
  bool operator ==(covariant CardRole other) => other.name == name;
  @override
  int get hashCode => super.hashCode;

  CardRole(this.role) {
    switch (this.role) {
      case RoleName.global:
        this.name = "Global";
        this.actions = [
          CardAction(ActionName.income, this.role),
          CardAction(ActionName.aid, this.role),
          CardAction(ActionName.coup, this.role),
        ];
        break;

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
}

enum RoleName { global, duke, contessa, assassin, ambassador, captain }

extension RoleColorExtention on RoleName {
  Color get color {
    switch (this) {
      case RoleName.global:
        return CoupColors.global;
      case RoleName.duke:
        return CoupColors.duke;
      case RoleName.contessa:
        return CoupColors.contessa;
      case RoleName.assassin:
        return CoupColors.assassin;
      case RoleName.ambassador:
        return CoupColors.ambassador;
      case RoleName.captain:
        return CoupColors.captain;
      default:
        return Colors.black;
    }
  }

  AssetImage get cardImage {
    switch (this) {
      case RoleName.duke:
        return AssetImage('assets/paintCardImg/duke.jpg');
      case RoleName.contessa:
        return AssetImage('assets/paintCardImg/contessa.jpg');
      case RoleName.assassin:
        return AssetImage('assets/paintCardImg/assassin.jpg');
      case RoleName.ambassador:
        return AssetImage('assets/paintCardImg/ambassador.jpg');
      case RoleName.captain:
        return AssetImage('assets/paintCardImg/captain.jpg');
      default:
        return AssetImage('assets/paintCardImg/base.jpg');
    }
  }
}
