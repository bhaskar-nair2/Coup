import 'package:coup/modals/isk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IskHolder extends StatelessWidget {
  const IskHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isk = Provider.of<Isk>(context);

    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      width: 70,
      height: 35,
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.asset(
            'assets/roleLogos/contessa.png',
            width: 25,
            height: 25,
          ),
          SizedBox(
            width: 25,
            child: Text(
              "${isk.counter}",
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
