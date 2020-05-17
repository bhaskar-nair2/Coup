import 'package:coup/modals/move.dart';

MoveType type = MoveType.action;

Move tax = Move(
  "tax",
  description: "Take 3 ISK as Tax, can't be blocked",
  type: type,
);
Move steal = Move(
  "steal",
  description: "Steal 2 ISK from any Player",
  type: type,
);
Move exchange = Move(
  "exchange",
  description: "Pick 2 cards from the pile, and keep one as an exchange",
  type: type,
);
Move assassinate = Move(
  "assassinate",
  description: "Pay 3 ISK to kill one card of any Player",
  type: type,
);

List<Move> actionMoves = [
  tax,
  steal,
  exchange,
  assassinate,
];
