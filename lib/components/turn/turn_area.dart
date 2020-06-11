import 'package:coup/components/turn/avail_actions.dart';
import 'package:coup/components/turn/global_actions.dart';
import 'package:coup/firebase/firedb.dart';
import 'package:coup/modals/firebase/game_table.dart';
import 'package:coup/modals/firebase/turn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TurnArea extends StatelessWidget {
  const TurnArea({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _table = Provider.of<GameTable>(context);
    var turnId = _table?.turn?.id ?? '';

    return MultiProvider(
      providers: [
        StreamProvider<Turn>.value(
          value: FirestoreService.turnStream(turnId),
          catchError: (context, error) {
            print(error);
            return Turn();
          },
        )
      ],
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: GlobalActions(),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                color: Colors.black26,
                child: AvailableActions(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
