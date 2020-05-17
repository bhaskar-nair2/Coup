import 'package:coup/modals/move.dart';

MoveType type = MoveType.passive;

Move vengence = Move(
  "vengence",
  description: "Get a free Assasination when killed. Can be blocked",
  type: type,
);
Move inheritance = Move(
  "inheritance",
  description: "Get 4 ISK when killled",
  type: type,
);
Move treaty = Move(
  "treaty",
  description: "Foreign Aid even when blocked",
  type: type,
);

List<Move> passiveMoves = [
  vengence,
  inheritance,
  treaty,
];
