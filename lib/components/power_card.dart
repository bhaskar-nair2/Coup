import 'package:coup/modals/ability.dart';
import 'package:coup/modals/action.dart';
import 'package:coup/modals/passive.dart';
import 'package:coup/modals/role.dart';
import 'package:flutter/material.dart';

class PowerCardHolder extends StatelessWidget {
  const PowerCardHolder(
    this.role, {
    Key key,
  }) : super(key: key);

  final CardRole role;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 108,
      child: Card(
        color: role.color,
        margin: EdgeInsets.all(5),
        child: Center(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 80, //85,
              child: Center(child: Text("Logo")),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                role.name.toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            AbilityBox(role: role)
          ],
        )),
      ),
    );
  }
}

class AbilityBox extends StatelessWidget {
  const AbilityBox({
    Key key,
    @required this.role,
    this.isActivated = false,
  }) : super(key: key);

  final CardRole role;
  final bool isActivated; // Passive is activated

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        children: <Widget>[
          // * ACTION
          if (role.action != CardAction.none)
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                role.action.description,
                style: TextStyle(fontSize: 8),
                textAlign: TextAlign.center,
              ),
            ),
          // * ABILITY
          if (role.ability != CardAbility.none)
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                role.ability.description,
                style: TextStyle(fontSize: 8),
                textAlign: TextAlign.center,
              ),
            ),
          // * PASSIVE
          if (role.passive != CardPassive.none) //&& isActivated)
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                role.passive.description,
                style: TextStyle(fontSize: 8, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            )
        ],
      ),
    );
  }
}
