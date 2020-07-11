import 'package:coup/data/actions/action_enums.dart';
import 'package:coup/data/role/role_enum.dart';
import 'package:coup/modals/game/actions.dart';
import 'package:coup/repos/game/actionFunctions.dart';

class RoleActions extends CardAction {
  static List<CardAction> get list => [tax, assassinate, exchange, steal];

  static final CardAction tax = CardAction.construct(
    action: ActionName.tax,
    name: "Tax",
    role: RoleName.duke,
    description: "Take 3 ISK as Tax",
    blockable: false,
    challengeable: true,
    caller: (context) => CallerFunctions.taxCall(context),
  );

  static final CardAction assassinate = CardAction.construct(
    action: ActionName.assassinate,
    name: "Assassinate",
    role: RoleName.assassin,
    description: "Pay 3 ISK to kill a Card",
    blockable: true,
    blocker: [ActionName.blockAssassin],
    challengeable: true,
    caller: (context) => CallerFunctions.assassinateCall(context),
  );

  static final CardAction exchange = CardAction.construct(
    action: ActionName.exchange,
    name: "Exchange",
    role: RoleName.ambassador,
    description: "Exchange this card",
    blockable: false,
    challengeable: true,
    caller: (context) => CallerFunctions.exchangeCall(context),
  );

  static final CardAction steal = CardAction.construct(
    action: ActionName.steal,
    name: "Steal",
    role: RoleName.captain,
    description: "Steal 2 ISK from any Player",
    blockable: true,
    blocker: [ActionName.blockSteal, ActionName.limitSteal],
    challengeable: true,
    caller: (context) => CallerFunctions.stealCall(context),
  );
}
