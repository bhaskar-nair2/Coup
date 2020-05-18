import 'package:coup/components/roleTile.dart';
import 'package:coup/modals/hand.dart';
import 'package:coup/modals/role.dart';
import 'package:flutter/material.dart';

class ExchangeDialog extends StatelessWidget {
  const ExchangeDialog({Key key, this.roles, this.hand}) : super(key: key);

  final List<RoleName> roles;
  final Hand hand;

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                    "Which card would you like to Keep?",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ...roles.map((role) {
                      return FlatButton(
                          onPressed: () => {
                                hand.exchange(1, role),
                                Navigator.of(context).pop()
                              },
                          child: SizedBox.fromSize(
                            size: Size(100, 120),
                            child: RoleTile(
                              role,
                              withActions: true,
                            ),
                          ));
                    }).toList()
                  ],
                )
              ]),
        ));
  }
}
