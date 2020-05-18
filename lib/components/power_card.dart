import 'package:coup/modals/hand.dart';
import 'package:coup/modals/role.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PowerCardHolder extends StatelessWidget {
  const PowerCardHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hand = Provider.of<Hand>(context);

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      itemCount: hand.cards.length,
      itemBuilder: (context, index) {
        final role = hand.cards[index];
        return AspectRatio(
          aspectRatio: 1 / 1.3,
          child: GestureDetector(
            onTap: () => role.actions[0].caller() ?? print(role.name),
            child: Card(
              color: role.role.color,
              elevation: 6,
              shadowColor: Colors.white54,
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
                ),
              ),
            ),
          ),
        );
      },
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
              style: TextStyle(fontSize: 8),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
