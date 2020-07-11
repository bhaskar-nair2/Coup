import 'dart:convert';

import 'package:coup/data/actions/action_enums.dart';
import 'package:coup/data/role/role_enum.dart';
import 'package:flutter/foundation.dart';

class CardAction {
  RoleName role;
  ActionName action;
  String name;
  String description;

  bool blockable = false;
  List<ActionName> blocker;
  bool challengeable = false;

  bool active = false; // Prolly suits more in abilities and passives
  Function caller;
  Function activator;

  CardAction();

  CardAction.construct({
    @required this.action,
    this.role,
    @required this.name,
    this.description,
    this.blockable,
    this.blocker,
    this.challengeable,
    this.caller,
    this.activator,
  }) : assert(blockable == true && blocker != null);

  setActive(bool value) {
    this.active = value;
  }

  static ActionName actionFromStr(String str) {
    ActionName action = ActionName.values.firstWhere(
        (e) => e.toString() == 'ActionName.' + str.toString().toLowerCase());
    return action;
  }

  String actionToStr() {
    var val = this.action.toString().split('.')[1];
    return val;
  }

  Map<String, dynamic> toMap() {
    return {
      'action': actionToStr(),
      'blockable': blockable,
      'challengeable': challengeable,
    };
  }

  String toJson() => json.encode(toMap());
}
