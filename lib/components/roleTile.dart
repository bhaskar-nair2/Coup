import 'package:coup/modals/action.dart';
import 'package:coup/modals/role.dart';
import 'package:flutter/material.dart';

class RoleTile extends StatelessWidget {
  const RoleTile(this.action, {Key key}) : super(key: key);
  final CardAction action;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        color: action.role.color,
        child: Center(
          child: Text("Logo"),
        ),
      ),
    );
  }
}
