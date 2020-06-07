import 'package:coup/modals/chance.dart';
import 'package:coup/modals/isk.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ActivationFunctions {
  static incomeActivation(BuildContext context, Function cb) {
    final chance = Provider.of<Chance>(context, listen: false);
    if (chance.active == true)
      cb(true);
    else
      cb(false);
    // TODO: Remove
    cb(true);
  }

  static aidActivation(BuildContext context, Function cb) {
    final chance = Provider.of<Chance>(context, listen: false);
    if (chance.active == true)
      cb(true);
    else
      cb(false);
    // TODO: Remove
    cb(true);
  }

  static coupActivation(BuildContext context, Function cb) {
    final chance = Provider.of<Chance>(context, listen: false);
    final isk = Provider.of<Isk>(context, listen: false);

    if (chance.active == true && chance.round >= 1 && isk.counter >= 7)
      cb(true);
    else
      cb(false);
    // TODO: Remove
    // cb(true);
  }
}
