import 'package:coup/modals/isk.dart';
import 'package:coup/modals/turn.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ActivationFunctions {
  final Turn _turn = Turn();

  static incomeActivation(BuildContext context, Function cb) {
    // if (chance.active == true)
    //   cb(true);
    // else
    //   cb(false);
    // // TODO: Remove
    cb(true);
  }

  static aidActivation(BuildContext context, Function cb) {
    // if (chance.active == true)
    //   cb(true);
    // else
    //   cb(false);
    // // TODO: Remove
    cb(false);
  }

  static coupActivation(BuildContext context, Function cb) {
    final isk = Provider.of<Isk>(context, listen: false);

    // if (chance.active == true && chance.round >= 1 && isk.counter >= 7)
    //   cb(true);
    // else
    //   cb(false);
    // // TODO: Remove
    cb(false);
  }
}
