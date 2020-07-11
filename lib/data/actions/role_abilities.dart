import 'package:coup/data/actions/action_enums.dart';
import 'package:coup/data/role/role_enum.dart';
import 'package:coup/modals/game/actions.dart';
import 'package:coup/repos/game/actionFunctions.dart';

class RoleAbilities extends CardAction {
  static List<CardAction> get list =>
      [blockAid, blockAssassin, blockSteal, limitSteal];

  static final CardAction blockAid = CardAction.construct(
    action: ActionName.blockAid,
    name: "Block Aid",
    description: "Block Foreign Aid",
    role: RoleName.duke,
    blockable: true,
    blocker: [ActionName.treaty],
    challengeable: true,
    caller: (context) => CallerFunctions.taxCall(context),
  );

  static final CardAction blockAssassin = CardAction.construct(
    action: ActionName.blockAssassin,
    name: "Block Assasination",
    description: "Block an Assassination attempt",
    role: RoleName.contessa,
    blockable: false,
    challengeable: true,
    caller: (context) => CallerFunctions.assassinateCall(context),
  );

  static final CardAction blockSteal = CardAction.construct(
    action: ActionName.blockSteal,
    name: "Block Stealing",
    description: "Block Stealing",
    role: RoleName.captain,
    blockable: false,
    challengeable: true,
    caller: (context) => CallerFunctions.exchangeCall(context),
  );

  static final CardAction limitSteal = CardAction.construct(
    action: ActionName.limitSteal,
    name: "Limit Stealing",
    description: "Limit Stealing",
    role: RoleName.ambassador,
    blockable: false,
    challengeable: true,
    caller: (context) => CallerFunctions.stealCall(context),
  );
}
