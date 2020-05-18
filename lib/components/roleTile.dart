import 'package:coup/modals/role.dart';
import 'package:flutter/material.dart';

class RoleTile extends StatelessWidget {
  const RoleTile(this.role, {Key key, this.withActions = false})
      : super(key: key);
  final RoleName role;
  final bool withActions;

  @override
  Widget build(BuildContext context) {
    CardRole card = CardRole(role);

    return AspectRatio(
      aspectRatio: withActions ? 1 / 1.2 : 1,
      child: Card(
        color: role.color,
        child: withActions
            ? Column(
                children: <Widget>[
                  SizedBox(
                    height: 70,
                    child: Center(child: FlutterLogo()),
                  ),
                  AbilityBox(role: card),
                ],
              )
            : Center(
                child: FlutterLogo(),
              ),
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
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: role.actions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              role.actions[index].name,
              style: TextStyle(
                fontSize: 8,
                color:
                    role.actions[index].active ? Colors.white : Colors.white24,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
