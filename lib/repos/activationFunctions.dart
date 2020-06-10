import 'package:coup/modals/turn.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ActivationFunctions {
  final Turn _turn = Turn();

  static bool incomeActivation(BuildContext context) {
    // if (chance.active == true)
    //   cb(true);
    // else
    //   cb(false);
    // // TODO: Remove
    return true;
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

    // if (chance.active == true && chance.round >= 1 && isk.counter >= 7)
    //   cb(true);
    // else
    //   cb(false);
    // // TODO: Remove
    cb(false);
  }
}
