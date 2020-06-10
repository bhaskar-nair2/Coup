import 'package:flutter/widgets.dart';

class ActivationFunctions {

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
