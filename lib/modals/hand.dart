import 'package:coup/modals/action.dart';
import 'package:coup/modals/role.dart';

class Hand {
  PlayState state;
  List<CardRole> cards;
  List<CardAction> actions; // All possible actions in the hand
  // List<CardAbility> abilities; // All possible abilities in the hand
  // List<CardPassive> passives; // All possible passives in the hand

  Hand(this.cards) {
    this.state = PlayState.two;
    this.actions = cards.expand((element) => element.actions).toList()
      ..removeWhere((v) => v == null);
  }

  killCard(index) {
    this.cards.removeAt(index);
    if (this.cards.length == 1)
      this.state = PlayState.one;
    else
      this.state = PlayState.out;
  }
}

enum PlayState { two, one, out }
