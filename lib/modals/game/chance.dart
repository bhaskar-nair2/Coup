import 'package:flutter/foundation.dart';

class Chance extends ChangeNotifier {
  // local chance system
  bool active = false;
  int round = 0;

  Chance({this.active});

  // setActive(String playerId) {
  //   this.activeId = playerId;
  //   print("$playerId ${IDManager.selfId}");
  //   if (playerId == IDManager.selfId) {
  //     this.active = true;
  //   } else
  //     this.active = false;
  // }
}
