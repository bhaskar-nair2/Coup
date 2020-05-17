import 'package:coup/modals/ability.dart';
import 'package:coup/modals/action.dart';
import 'package:coup/modals/passive.dart';
import 'package:coup/modals/role.dart';

class Hand {
  PlayState state;
  List<CardRole> cards;
  List<CardAction> actions;
  List<CardAbility> abilities;
  List<CardPassive> passive;

  Hand(this.cards) {
    this.state = PlayState.two;
    this.actions = cards
        .where((e) => e.action != CardAction.none)
        .map((e) => e.action)
        .toList();
    this.abilities = cards
        .where((e) => e.ability != CardAbility.none)
        .map((e) => e.ability)
        .toList();
    this.passive = cards
        .where((e) => e.passive != CardPassive.none)
        .map((e) => e.passive)
        .toList();
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
