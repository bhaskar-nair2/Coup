import 'package:coup/data/actions/role_abilities.dart';
import 'package:coup/data/actions/role_actions.dart';
import 'package:coup/data/actions/role_passives.dart';
import 'package:coup/modals/game/actions.dart';
import 'basic_actions.dart';

enum ActionType { action, ability, passive, challenge }

enum ActionName {
  // basics
  income,
  aid,
  coup,
  challenge,
  // action
  tax,
  assassinate,
  exchange,
  steal,
  // ability
  blockAid,
  blockAssassin,
  blockSteal,
  limitSteal,
  // passive
  vengence,
  inheritance,
  treaty,
}

extension ActionNameExt on ActionName {
  // ignore: missing_return
  CardAction getAssociatedAction() {
    switch (this) {
      // basics
      case ActionName.income:
        return BasicActions.income;
      case ActionName.aid:
        return BasicActions.aid;
      case ActionName.coup:
        return BasicActions.coup;
      case ActionName.challenge:
        return BasicActions.challenge;
      // actions
      case ActionName.tax:
        return RoleActions.tax;
      case ActionName.assassinate:
        return RoleActions.assassinate;
      case ActionName.exchange:
        return RoleActions.exchange;
      case ActionName.steal:
        return RoleActions.steal;
      // abilities
      case ActionName.blockAid:
        return RoleAbilities.blockAid;
      case ActionName.blockAssassin:
        return RoleAbilities.blockAssassin;
      case ActionName.blockSteal:
        return RoleAbilities.blockSteal;
      case ActionName.limitSteal:
        return RoleAbilities.limitSteal;
      // passives
      case ActionName.vengence:
        return RolePassives.vengence;
      case ActionName.inheritance:
        return RolePassives.inheritance;
      case ActionName.treaty:
        return RolePassives.treaty;
    }
  }
}
