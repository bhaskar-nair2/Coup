import 'package:coup/modals/firebase/self.dart';
import 'package:coup/modals/game/isk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IskHolder extends StatelessWidget {
  IskHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _self = Provider.of<SelfPlayer>(context);

    final isk = _self?.isk ?? Isk(0);

    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      width: 70,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.asset(
            'assets/paintCardImg/iskImg.png',
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
