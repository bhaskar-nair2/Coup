import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/components/self/isk_holder.dart';
import 'package:coup/components/self/power_card.dart';
import 'package:coup/modals/game/hand.dart';
import 'package:coup/modals/game/isk.dart';
import 'package:coup/modals/self.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelfArea extends StatefulWidget {
  const SelfArea({
    Key key,
  }) : super(key: key);

  @override
  _SelfAreaState createState() => _SelfAreaState();
}

class _SelfAreaState extends State<SelfArea> {
  final SelfPlayer _self = SelfPlayer();
  final HttpsCallable leaveTableFunction = CloudFunctions.instance
      .getHttpsCallable(functionName: 'tableFunctions-leaveTable');

  @override
  void dispose() {
    leaveTableFunction.call(<String, dynamic>{
      'tableId': 'ymAmWOuxrNYwXxWDg1Mo',
      'userId': _self.uid,
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Hand>.value(value: _self.hand),
        ChangeNotifierProvider<Isk>.value(value: _self.isk),
      ],
      child: Container(
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
      ),
    );
  }
}
