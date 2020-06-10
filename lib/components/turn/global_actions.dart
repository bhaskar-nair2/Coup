import 'package:coup/components/turn/avail_actions.dart';
import 'package:flutter/material.dart';

class GlobalActions extends StatelessWidget {
  const GlobalActions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: <Widget>[
          Container(
            height: 60,
            width: 60,
            color: Colors.grey.shade300,
          ),
          Container(
            height: 60,
            width: 60,
            color: Colors.grey.shade300,
          ),
          Container(
            height: 60,
            width: 60,
            color: Colors.grey.shade300,
          )
        ],
      ),
    );
  }
}
