import 'package:coup/data/actions/action_enums.dart';
import 'package:coup/modals/game/actions.dart';
import 'package:coup/repos/game/actionFunctions.dart';
import 'package:coup/repos/game/activationFunctions.dart';

class BasicActions extends CardAction {
  static List<CardAction> get list => [income, aid, coup];

  static final CardAction income = CardAction.construct(
    action: ActionName.income,
    name: "Income",
    description: "Take 1 ISK as Income",
    blockable: false,
    challengeable: false,
    caller: (context) => CallerFunctions.incomeCall(context),
    activator: (context) => ActivationFunctions.incomeActivation(context),
  );

  static final CardAction aid = CardAction.construct(
    action: ActionName.aid,
    name: "Foreign Aid",
    description: "Take 2 ISK as foreign aid",
    blockable: true,
    blocker: [ActionName.blockAid],
    challengeable: false,
    caller: (context) => CallerFunctions.aidCall(context),
    activator: (context) => ActivationFunctions.aidActivation(context),
  );

  static final CardAction coup = CardAction.construct(
    action: ActionName.coup,
    name: "COUP",
    description: "Pay 7 ISK to kill one card of any Player",
    blockable: false,
    challengeable: false,
    caller: (context) => CallerFunctions.coupCall(context),
    activator: (context) => ActivationFunctions.coupActivation(context),
  );
}
