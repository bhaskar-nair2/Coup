import 'package:coup/modals/game/action.dart';
import 'package:coup/repos/game/actionFunctions.dart';

class RoleCardActions {
  static final type = ActionType.action;

  List<CardAction> get list => [tax, assassinate, exchange, steal];

  static final CardAction tax = CardAction(
    ActionName.tax,
    name: "Tax",
    description: "Take 3 ISK as Tax",
    type: type,
    blockable: false,
    challengeable: true,
    caller: (context) => CallerFunctions.taxCall(context),
  );

  static final CardAction assassinate = CardAction(
    ActionName.assassinate,
    name: "Assassinate",
    description: "Pay 3 ISK to kill a Card",
    type: type,
    blockable: true,
    challengeable: true,
    caller: (context) => CallerFunctions.assassinateCall(context),
  );

  static final CardAction exchange = CardAction(
    ActionName.exchange,
    name: "Exchange",
    description: "Exchange this card",
    type: type,
    blockable: false,
    challengeable: true,
    caller: (context) => CallerFunctions.exchangeCall(context),
  );

  static final CardAction steal = CardAction(
    ActionName.steal,
    name: "Steal",
    description: "Steal 2 ISK from any Player",
    type: type,
    blockable: true,
    challengeable: true,
    caller: (context) => CallerFunctions.stealCall(context),
  );
}
