import 'package:coup/components/self/isk_holder.dart';
import 'package:coup/components/self/pause_menu.dart';
import 'package:coup/components/self/power_card.dart';
import 'package:coup/components/self/timer_holder.dart';
import 'package:flutter/material.dart';

class SelfArea extends StatelessWidget {
  const SelfArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.clip,
      alignment: Alignment.topLeft,
      children: <Widget>[
        IskHolder(),
        PowerCardHolder(),
        TimerHolder(),
        PauseMenu()
      ],
    );
  }
}
