import 'package:coup/modals/firebase/fbModels.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ActivationFunctions {
  static bool incomeActivation(BuildContext context) {
    var _turn = Provider.of<Turn>(context, listen: false);

    if (_turn?.chance?.active == true ?? false)
      return true;
    else
      return false;
  }

  static bool aidActivation(BuildContext context) {
    var _turn = Provider.of<Turn>(context, listen: false);
    if (_turn?.chance?.active == true ?? false)
      return true;
    else
      return false;
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
