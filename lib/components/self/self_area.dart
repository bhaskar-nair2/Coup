import 'package:coup/components/self/isk_holder.dart';
import 'package:coup/components/self/power_card.dart';
import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/game/hand.dart';
import 'package:coup/modals/game/isk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelfArea extends StatelessWidget {
  const SelfArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Stack(
        overflow: Overflow.clip,
        alignment: Alignment.topLeft,
        children: <Widget>[
          IskHolder(),
          Positioned.directional(
            textDirection: TextDirection.ltr,
            bottom: 20,
            start: -30,
            child: PowerCardHolder(),
          ),
        ],
      ),
    );
  }
}
