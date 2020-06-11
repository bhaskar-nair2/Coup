import 'package:coup/modals/firebase/self.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ActivationFunctions {
  static bool incomeActivation(BuildContext context) {
    // if (chance.active == true)
    //   cb(true);
    // else
    //   cb(false);
    // // TODO: Remove
    return true;
  }

  static bool aidActivation(BuildContext context) {
    // if (chance.active == true)
    //   cb(true);
    // else
    //   cb(false);
    // // TODO: Remove
    return true;
  }

  static bool coupActivation(BuildContext context) {
    var _self = Provider.of<SelfPlayer>(context, listen: false);
    var iskCount = _self?.isk?.counter ?? 0;

    if (iskCount >= 7)
      return true;
    else
      return false;
  }
}
