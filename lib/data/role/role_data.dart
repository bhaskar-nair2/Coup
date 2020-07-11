import 'package:coup/data/actions/role_abilities.dart';
import 'package:coup/data/actions/role_actions.dart';
import 'package:coup/data/actions/role_passives.dart';
import 'package:coup/data/role/role_enum.dart';
import 'package:coup/modals/game/role.dart';

class RoleData extends CardRole {
  static List<CardRole> get list =>
      [duke, contessa, assassin, ambassador, captain];

  static final CardRole duke = CardRole.construct(
    role: RoleName.duke,
    name: "duke",
    action: RoleActions.tax,
    ability: RoleAbilities.blockAid,
  );

  static final CardRole contessa = CardRole.construct(
    role: RoleName.contessa,
    name: "contessa",
    ability: RoleAbilities.blockAssassin,
    passive: RolePassives.treaty,
  );

  static final CardRole assassin = CardRole.construct(
    role: RoleName.assassin,
    name: "assassin",
    action: RoleActions.assassinate,
    passive: RolePassives.vengence,
  );

  static final CardRole ambassador = CardRole.construct(
    role: RoleName.ambassador,
    name: "ambassador",
    action: RoleActions.exchange,
    ability: RoleAbilities.limitSteal,
    passive: RolePassives.inheritance,
  );

  static final CardRole captain = CardRole.construct(
    role: RoleName.captain,
    name: "captain",
    action: RoleActions.steal,
    ability: RoleAbilities.blockSteal,
  );
}
