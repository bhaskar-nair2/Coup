import 'package:coup/modals/isk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IskHolder extends StatelessWidget {
  const IskHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isk = Provider.of<Isk>(context);
    return Container(
      child: Text(
        "ISK: ${isk.counter}",
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
