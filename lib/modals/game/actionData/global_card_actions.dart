import 'package:coup/modals/game/action.dart';
import 'package:coup/repos/activationFunctions.dart';
import 'package:coup/repos/callerFunctions.dart';

class GlobalCardActions extends CardAction {
  GlobalCardActions(ActionName action) : super(action);

  static List<CardAction> get list => [income, aid, coup];

  static final CardAction income = CardAction(
    ActionName.income,
    name: "Income",
    description: "Take 1 ISK as Income",
    blockable: false,
    challengeable: false,
    caller: (context) => CallerFunctions.incomeCall(context),
    activator: (context) => ActivationFunctions.incomeActivation(context),
  );

  static final CardAction aid = CardAction(
    ActionName.aid,
    name: "Foreign Aid",
    description: "Take 2 ISK as foreign aid",
    blockable: true,
    challengeable: false,
    caller: (context) => CallerFunctions.aidCall(context),
     activator: (context) => ActivationFunctions.aidActivation(context),
  );

  static final CardAction coup = CardAction(
    ActionName.coup,
    name: "COUP",
    description: "Pay 7 ISK to kill one card of any Player",
    blockable: false,
    challengeable: false,
    caller: (context) => CallerFunctions.coupCall(context),
     activator: (context) => ActivationFunctions.coupActivation(context),
  );
}
