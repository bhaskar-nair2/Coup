import 'package:coup/modals/game/hand.dart';
import 'package:coup/modals/game/isk.dart';
import 'package:flutter/foundation.dart';

class SelfPlayer extends ChangeNotifier {
  Hand hand = Hand();
  Isk isk = Isk(0);
  String tableId;

  SelfPlayer();

  SelfPlayer.fromFirestore(Map data) {
    List<String> handList = List.castFrom(data['hand'] as List ?? []);
    this.isk = Isk(data['isk']);
    this.hand = Hand.fromList(handList);
    this.tableId = data['table'];
  }
}
