import 'package:coup/components/turn/avail_actions.dart';
import 'package:coup/components/turn/global_actions.dart';
import 'package:flutter/material.dart';

class TurnArea extends StatelessWidget {
  const TurnArea({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 80,
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
    );
  }
}
