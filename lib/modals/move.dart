import 'package:flutter/material.dart';

class Move {
  String name;
  String description;
  MoveType type;
  bool active;
  Function caller;
  Function activation;

  Move(String name, {this.description, this.type}) {
    this.name = name.toUpperCase();
  }

  factory Move.none() {
    return null;
  }
}

enum MoveType { action, ability, passive }

extension MoveTypeExtention on MoveType {
  Color get color {
    switch (this) {
      case MoveType.action:
        return Colors.blue;
        break;
      case MoveType.ability:
        return Colors.orange;
        break;
      case MoveType.passive:
        return Colors.teal;
        break;
      default:
        return Colors.black;
    }
  }
}
