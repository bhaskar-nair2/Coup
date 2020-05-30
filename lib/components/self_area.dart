import 'package:coup/components/isk_holder.dart';
import 'package:coup/components/power_card.dart';
import 'package:flutter/material.dart';

class SelfArea extends StatelessWidget {
  const SelfArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IskHolder(),
                    PowerCardHolder(),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
