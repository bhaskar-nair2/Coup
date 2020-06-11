import 'package:coup/modals/game/action.dart';
import 'package:coup/modals/game/role.dart';
import 'package:flutter/foundation.dart';

class Hand extends ChangeNotifier {
  PlayState state = PlayState.out;
  List<CardRole> _cards = [];

  List<CardRole> get cards => _cards;
  List<CardAction> get actions =>
      this.cards.expand((element) => element.actions).toList()
        ..removeWhere((v) => v == null);

  Hand();

  Hand.fromList(List<String> cardsArr) {
    this.cards = strToRole(cardsArr); // setter
  }

  set cards(List<CardRole> cards) {
    _cards = cards;
    this.refreshHand();
  }

  static List<CardRole> strToRole(List<String> cards) {
    List<CardRole> cardRoles = List.generate(cards.length, (index) {
      return CardRole(RoleName.values.firstWhere(
        (e) =>
            e.toString() == 'RoleName.' + cards[index].toString().toLowerCase(),
        orElse: () => null,
      ));
    });
    return cardRoles;
  }

  refreshHand() {
    if (this.cards.length == 2)
      this.state = PlayState.two;
    else if (this.cards.length == 1)
      this.state = PlayState.one;
    else
      this.state = PlayState.out;
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
