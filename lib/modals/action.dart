import 'package:coup/modals/chance.dart';
import 'package:coup/modals/hand.dart';
import 'package:coup/modals/isk.dart';
import 'package:coup/modals/role.dart';
import 'package:provider/provider.dart';

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
  bool active;
  Function caller;
  Function activator;

  setActive(bool value) {
    this.active = value;
  }

  CardAction(this.action, this.role) {
    this.active = true;
    switch (this.action) {
      case ActionName.income:
        this.name = "Income";
        this.description = "Take 1 ISK as Income";
        this.type = ActionType.utility;
        this.caller = (context) {
          final isk = Provider.of<Isk>(context, listen: false);
          isk.increment(1);
        };
        this.activator = (context) {
          final chance = Provider.of<Chance>(context, listen: false);
          if (chance.active == true)
            this.setActive(true);
          else
            this.setActive(false);
        };
        break;
      case ActionName.aid:
        this.name = "Tax";
        this.description = "Take 2 ISK as foreign aid, non-blockable";
        this.type = ActionType.utility;
        this.caller = (context) {
          final isk = Provider.of<Isk>(context, listen: false);
          isk.increment(2);
        };
        break;
      case ActionName.coup:
        this.name = "Coup";
        this.description = "Pay 7 ISK to kill one card of any Player";
        this.type = ActionType.utility;
        this.caller = (Isk isk) {
          isk.increment(3);
        };
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
        this.caller = (Hand hand) {
          hand.killCard(0);
          print(hand.cards);
        };
        break;

      case ActionName.exchange:
        this.name = "Exchange";
        this.description =
            "Pick 2 cards from the pile, and keep one as an exchange";
        this.type = ActionType.action;
        this.caller = (Hand hand) {
          hand.exchange(1, RoleName.contessa);
          print(hand.cards);
        };
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
