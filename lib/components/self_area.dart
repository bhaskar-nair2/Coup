import 'package:cloud_functions/cloud_functions.dart';
import 'package:coup/components/isk_holder.dart';
import 'package:coup/components/power_card.dart';
import 'package:coup/modals/self.dart';
import 'package:flutter/material.dart';

class SelfArea extends StatefulWidget {
  const SelfArea({
    Key key,
  }) : super(key: key);

  @override
  _SelfAreaState createState() => _SelfAreaState();
}

class _SelfAreaState extends State<SelfArea> {
  final SelfPlayer self = SelfPlayer();
  final HttpsCallable leaveTableFunction = CloudFunctions.instance
      .getHttpsCallable(functionName: 'tableFunctions-leaveTable');

  @override
  void dispose() {
    leaveTableFunction.call(<String, dynamic>{
      'tableId': 'ymAmWOuxrNYwXxWDg1Mo',
      'userId': self.uid,
    });
    super.dispose();
  }

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
