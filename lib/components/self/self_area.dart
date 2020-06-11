import 'package:coup/components/self/isk_holder.dart';
import 'package:coup/components/self/power_card.dart';
import 'package:flutter/material.dart';

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
          PowerCardHolder(),
        ],
      ),
    );
  }
}
