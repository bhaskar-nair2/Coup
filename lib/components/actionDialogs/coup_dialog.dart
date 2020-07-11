import 'package:coup/data/role/role_enum.dart';
import 'package:coup/modals/firebase/fbModels.dart';
import 'package:coup/modals/game/hand.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoupDialog extends StatelessWidget {
  const CoupDialog({Key key, this.roles, this.hand}) : super(key: key);

  final List<RoleName> roles;
  final Hand hand;

  @override
  Widget build(BuildContext context) {
    var table = Provider.of<GameTable>(context);

    return Dialog(
        backgroundColor: Color(0xff092147),
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 200,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Which player would you like to Coup?",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ...roles.map((role) {
                      return FlatButton(
                          onPressed: () => {print('Coup him')},
                          child: SizedBox.fromSize(
                            size: Size(100, 120),
                          ));
                    }).toList()
                  ],
                )
              ]),
        ));
  }
}
