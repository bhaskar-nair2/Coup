import 'package:coup/modals/firebase/fbModels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoupDialog extends StatelessWidget {
  const CoupDialog(this.extContext, {Key key}) : super(key: key);

  final BuildContext extContext;

  @override
  Widget build(BuildContext context) {
    var table = Provider.of<GameTable>(extContext);

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
                    ...table.players.map((player) {
                      return FlatButton(
                          onPressed: () => Navigator.pop(context, player),
                          child: SizedBox.fromSize(
                            size: Size(100, 120),
                            child: Text(player.toString()),
                          ));
                    }).toList()
                  ],
                )
              ]),
        ));
  }
}
