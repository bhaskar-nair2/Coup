import 'package:coup/modals/isk.dart';
import 'package:coup/modals/role.dart';
import 'package:coup/repos/activationFunctions.dart';
import 'package:coup/repos/callerFunctions.dart';

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
  vengence,
  inheritance,
  treaty
}

enum ActionType { utility, action, ability, passive }

class CardAction {
  RoleName role;
  ActionName action;
  ActionType type;
  String name;
  String description;

  bool blockable;
  bool challengeable;
  bool active; // Prolly suits more in abilities and passives
  Function caller;
  Function activator;

  final CallerFunctions _callerFns = CallerFunctions();

  setActive(bool value) {
    this.active = value;
  }

  CardAction(this.action, this.role) {
    this.active = true; //TODO: false
    switch (this.action) {
      case ActionName.income:
        this.name = "Income";
        this.description = "Take 1 ISK as Income";
        this.blockable = false;
        this.challengeable = false;
        this.type = ActionType.utility;
        this.caller = (context) => _callerFns.incomeCall(context);
        this.activator = (context) =>
            ActivationFunctions.incomeActivation(context, this.setActive);
        break;
      case ActionName.aid:
        this.name = "Foreign Aid";
        this.description = "Take 2 ISK as foreign aid, non-blockable";
        this.type = ActionType.utility;
        this.caller = (context) => _callerFns.aidCall(context);
        this.activator = (context) =>
            ActivationFunctions.aidActivation(context, this.setActive);
        break;
      case ActionName.coup:
        this.name = "COUP";
        this.description = "Pay 7 ISK to kill one card of any Player";
        this.type = ActionType.utility;
        this.caller = (context) => CallerFunctions.coupCall(context);
        this.activator = (context) =>
            ActivationFunctions.coupActivation(context, this.setActive);
        break;
      case ActionName.tax:
        this.name = "Tax";
        this.description = "Take 3 ISK as Tax, can't be blocked";
        this.type = ActionType.action;
        this.caller = (Isk isk) {
          isk.increment(3);
        };
        break;

      case ActionName.assassinate:
        this.name = "Assassinate";
        this.description =
            "Pay 3 ISK to kill one card of any Player, Blockable";
        this.type = ActionType.action;
        this.caller = (context) => CallerFunctions.assassinateCall(context);
        break;

      case ActionName.exchange:
        this.name = "Exchange";
        this.description =
            "Pick 2 cards from the pile, and keep one as an exchange";
        this.type = ActionType.action;
        this.caller = (context) => CallerFunctions.exchangeCall(context);
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
