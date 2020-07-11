import 'package:coup/data/role/role_data.dart';
import 'package:coup/modals/game/role.dart';
import 'package:coup/style.dart';
import 'package:flutter/material.dart';

enum RoleName { duke, contessa, assassin, ambassador, captain }

extension RoleExtention on RoleName {
  // ignore: missing_return
  CardRole getAssociatedRole() {
    switch (this) {
      case RoleName.duke:
        return RoleData.duke;
      case RoleName.contessa:
        return RoleData.contessa;
      case RoleName.assassin:
        return RoleData.assassin;
      case RoleName.ambassador:
        return RoleData.ambassador;
      case RoleName.captain:
        return RoleData.captain;
    }
  }

  Color get color {
    switch (this) {
      case RoleName.duke:
        return CoupColors.duke;
      case RoleName.contessa:
        return CoupColors.contessa;
      case RoleName.assassin:
        return CoupColors.assassin;
      case RoleName.ambassador:
        return CoupColors.ambassador;
      case RoleName.captain:
        return CoupColors.captain;
    }
  }

  AssetImage get cardImage {
    switch (this) {
      case RoleName.duke:
        return AssetImage('assets/paintCardImg/duke.jpg');
      case RoleName.contessa:
        return AssetImage('assets/paintCardImg/contessa.jpg');
      case RoleName.assassin:
        return AssetImage('assets/paintCardImg/assassin.jpg');
      case RoleName.ambassador:
        return AssetImage('assets/paintCardImg/ambassador.jpg');
      case RoleName.captain:
        return AssetImage('assets/paintCardImg/captain.jpg');
    }
  }
}
