import 'package:coup/modals/move.dart';

MoveType type = MoveType.ability;

Move blockAid = Move(
  "Block Aid",
  description: "Block Foreign Aid",
  type: type,
);

Move blockAssassin = Move(
  "Block Assassin",
  description: "Block an Assassination attempt",
  type: type,
);
Move blockSteal = Move(
  "Block Steal",
  description: "Block Stealing",
  type: type,
);
Move limitSteal = Move(
  "Limit Steal",
  description: "Limit Stealing to 1 ISK",
  type: type,
);

List<Move> abilityMoves = [
  blockAid,
  blockAssassin,
  blockSteal,
  limitSteal,
];
