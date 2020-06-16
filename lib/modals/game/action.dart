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

  // Map<String, dynamic> toMap() {
  //   return {
  //     'role': role?.toMap(),
  //     'action': action?.toMap(),
  //     'type': type?.toMap(),
  //     'name': name,
  //     'description': description,
  //     'active': active,
  //     'caller': caller?.toMap(),
  //     'activator': activator?.toMap(),
  //   };
  // }

  // static CardAction fromMap(Map<String, dynamic> map) {
  //   if (map == null) return null;

  //   return CardAction(
  //     RoleName.fromMap(map['role']),
  //     ActionName.fromMap(map['action']),
  //     ActionType.fromMap(map['type']),
  //     map['name'],
  //     map['description'],
  //     map['active'],
  //     Function.fromMap(map['caller']),
  //     Function.fromMap(map['activator']),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // static CardAction fromJson(String source) => fromMap(json.decode(source));
}
