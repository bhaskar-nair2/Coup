import 'package:coup/modals/action.dart';
import 'package:coup/modals/role.dart';
import 'package:flutter/foundation.dart';

class Hand extends ChangeNotifier {
  PlayState state;
  List<CardRole> cards;
  List<CardAction> actions; // All possible actions in the hand

  // Singleton
  static final Hand _hand = Hand._internal();

  factory Hand(List<CardRole> cards) {
    _hand.cards = cards;
    _hand.state = PlayState.two;
    _hand.actions = cards.expand((element) => element.actions).toList()
      ..removeWhere((v) => v == null);
    return _hand;
  }

  Hand._internal();

  refreshHand() {
    if (this.cards.length == 2)
      this.state = PlayState.two;
    else if (this.cards.length == 1)
      this.state = PlayState.one;
    else
      this.state = PlayState.out;
    this.actions = cards.expand((element) => element.actions).toList()
      ..removeWhere((v) => v == null);
    notifyListeners();
  }

  killCard(int index) {
    this.cards.removeAt(index);
    refreshHand();
  }

  exchange(int index, RoleName newRole) {
    this.cards.removeAt(index);
    this.cards.add(CardRole(newRole));
    refreshHand();
  }
}

enum PlayState { two, one, out }
