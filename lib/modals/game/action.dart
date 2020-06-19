import 'dart:convert';

import 'package:coup/modals/game/actionData/global_card_actions.dart';
import 'package:coup/modals/game/role.dart';

enum ActionName {
  income,
  aid,
  coup,

  tax,
  assassinate,
  exchange,
  steal,

  blockAid,
  blockAssassin,
  blockSteal,
  limitSteal,

  // passives??
  vengence,
  inheritance,
  treaty
}

enum ActionType { utility, action, ability, passive }

extension ActionNameExt on ActionName {
  CardAction getAssociatedAction() {
    switch (this) {
      case ActionName.income:
        return GlobalCardActions.income;
      case ActionName.aid:
        return GlobalCardActions.aid;
      case ActionName.coup:
        return GlobalCardActions.coup;
      // case ActionName.tax:
      //   break;
      // case ActionName.assassinate:
      //   break;
      // case ActionName.exchange:
      //   break;
      default:
        return GlobalCardActions.income;
    }
  }
}

class CardAction {
  RoleName role;
  ActionName action;
  String name;
  String description;
  ActionType type;

  bool blockable;
  bool challengeable;
  bool active = false; // Prolly suits more in abilities and passives
  Function caller;
  Function activator;

  setActive(bool value) {
    this.active = value;
  }

  static ActionName actionFromStr(String str) {
    ActionName action = ActionName.values.firstWhere(
        (e) => e.toString() == 'ActionName.' + str.toString().toLowerCase());
    return action;
  }

  static String actionToStr(ActionName act) {
    var val = act.toString().split('.')[1];
    return val;
  }

  CardAction(
    this.action, {
    this.role,
    this.name,
    this.description,
    this.type,
    this.blockable,
    this.challengeable,
    this.caller,
    this.activator,
  });

  CardAction.fromSome(this.action, this.role) {
    this.active = true;
    switch (this.action) {
      case ActionName.income:
        break;
      case ActionName.aid:
        break;
      case ActionName.coup:
        break;
      case ActionName.tax:
        break;
      case ActionName.assassinate:
        break;
      case ActionName.exchange:
        break;

      case ActionName.steal:
        this.name = "Steal";
        this.description = "Steal 2 ISK from any Player";
        this.type = ActionType.action;
        break;

      case ActionName.blockAid:
        this.name = "Block Aid";
        this.description = "Block Foreign Aid";
        this.type = ActionType.ability;
        break;

      case ActionName.blockAssassin:
        this.name = "Block Assasination";
        this.description = "Block an Assassination attempt";
        this.type = ActionType.ability;
        break;

      case ActionName.blockSteal:
        this.name = "Block Stealing";
        this.description = "Block Stealing";
        this.type = ActionType.ability;
        break;

      case ActionName.limitSteal:
        this.name = "Limit Stealing";
        this.description = "Limit Stealing to 1 ISK";
        this.type = ActionType.ability;
        break;

      case ActionName.vengence:
        this.name = "Vengence";
        this.description =
            "Get a free Assasination when killed. Can be blocked";
        this.type = ActionType.passive;
        break;

      case ActionName.inheritance:
        this.name = "Inheritance";
        this.description = "Get 4 ISK when killled";
        this.type = ActionType.passive;
        break;

      case ActionName.treaty:
        this.name = "Treaty";
        this.description = "Foreign Aid even when blocked";
        this.type = ActionType.passive;
        break;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'action': actionToStr(action),
      'name': name,
      'blockable': blockable,
      'challengeable': challengeable,
    };
  }

  String toJson() => json.encode(toMap());
}
