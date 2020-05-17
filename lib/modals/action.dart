import 'package:coup/modals/move.dart';

enum ActionName {
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

enum ActionType { action, ability, passive }

class CardAction {
  ActionName action;
  ActionType type;
  String name;
  String description;
  bool active;

  CardAction(this.action) {
    this.active = false;
    switch (this.action) {
      case ActionName.tax:
        this.name = "Tax";
        this.description = "Take 3 ISK as Tax, can't be blocked";
        this.type = ActionType.action;
        break;

      case ActionName.assassinate:
        this.name = "Assassinate";
        this.description = "Pay 3 ISK to kill one card of any Player";
        this.type = ActionType.action;
        break;

      case ActionName.exchange:
        this.name = "Exchange";
        this.description =
            "Pick 2 cards from the pile, and keep one as an exchange";
        this.type = ActionType.action;
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
}
