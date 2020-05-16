import 'package:coup/modals/ability.dart';
import 'package:coup/modals/action.dart';
import 'package:coup/modals/passive.dart';
import 'package:coup/style.dart';
import 'package:flutter/material.dart';

enum CardRole { duke, contessa, assassin, ambassador, captain }

extension CardRoleExtension on CardRole {
  String get name {
    switch (this) {
      case CardRole.duke:
        return 'Duke';

      case CardRole.contessa:
        return "Contessa";

      case CardRole.assassin:
        return "Assassin";

      case CardRole.ambassador:
        return "Ambassador";

      case CardRole.captain:
        return "Captain";
      default:
        return "";
    }
  }

  Color get color {
    switch (this) {
      case CardRole.duke:
        return CoupColors.duke;

      case CardRole.contessa:
        return CoupColors.contessa;

      case CardRole.assassin:
        return CoupColors.assassin;

      case CardRole.captain:
        return CoupColors.captain;

      case CardRole.ambassador:
        return CoupColors.ambassador;

      default:
        return Colors.white;
    }
  }

  CardAction get action {
    switch (this) {
      case CardRole.duke:
        return CardAction.tax;

      case CardRole.contessa:
        return CardAction.none;

      case CardRole.assassin:
        return CardAction.assassinate;

      case CardRole.captain:
        return CardAction.steal;

      case CardRole.ambassador:
        return CardAction.exchange;

      default:
        return CardAction.none;
    }
  }

  CardAbility get ability {
    switch (this) {
      case CardRole.duke:
        return CardAbility.block_aid;

      case CardRole.contessa:
        return CardAbility.block_assassin;

      case CardRole.assassin:
        return CardAbility.none;

      case CardRole.captain:
        return CardAbility.block_steal;

      case CardRole.ambassador:
        return CardAbility.limit_steal;

      default:
        return CardAbility.none;
    }
  }

  CardPassive get passive {
    switch (this) {
      case CardRole.duke:
        return CardPassive.none;

      case CardRole.contessa:
        return CardPassive.treaty;

      case CardRole.assassin:
        return CardPassive.vengence;

      case CardRole.captain:
        return CardPassive.none;

      case CardRole.ambassador:
        return CardPassive.inheritance;

      default:
        return CardPassive.none;
    }
  }
}
