import 'package:coup/data/role/role_enum.dart';
import 'package:coup/modals/game/actions.dart';
import 'package:flutter/foundation.dart';

class CardRole {
  RoleName role;
  String name;
  CardAction action;
  CardAction ability;
  CardAction passive;

  @override
  bool operator ==(covariant CardRole other) => other.name == name;
  @override
  int get hashCode => super.hashCode;

  CardRole();

  CardRole.construct({
    @required this.role,
    this.name,
    this.action,
    this.ability,
    this.passive,
  });
}
