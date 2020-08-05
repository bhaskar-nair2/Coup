import 'package:coup/data/actions/action_enums.dart';
import 'package:coup/data/role/role_enum.dart';
import 'package:coup/modals/game/actions.dart';
import 'package:coup/repos/game/actionFunctions.dart';

class RolePassives extends CardAction {
  static List<CardAction> get list => [vengence, inheritance, treaty];

  static final CardAction vengence = CardAction.construct(
    action: ActionName.vengence,
    name: "Vengence",
    description: "Free Assasination when killed. Can be blocked",
    type: ActionType.passive,
    role: RoleName.assassin,
    blockable: true,
    blocker: [ActionName.blockAssassin],
    challengeable: false,
    caller: (context) => CallerFunctions.taxCall(context),
  );

  static final CardAction inheritance = CardAction.construct(
    action: ActionName.inheritance,
    name: "Inheritance",
    description: "Get 4 ISK when killled",
    type: ActionType.passive,
    role: RoleName.contessa,
    blockable: false,
    challengeable: false,
    caller: (context) => CallerFunctions.assassinateCall(context),
  );

  static final CardAction treaty = CardAction.construct(
    action: ActionName.treaty,
    name: "Treaty",
    description: "Unblock Foreign Aid",
    type: ActionType.passive,
    role: RoleName.captain,
    blockable: false,
    challengeable: false,
    caller: (context) => CallerFunctions.exchangeCall(context),
  );
}
