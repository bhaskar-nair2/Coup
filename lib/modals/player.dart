import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/action.dart';

class Player {
  DocumentReference ref;
  String name;
  int cards;
  int isk;
  bool self;

  Player({this.ref, this.cards, this.isk});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cards': cards,
      'isk': isk,
    };
  }

  static Player fromMap(Map<String, dynamic> map) {
    return Player(
      ref: map['player'], // playerREf
      cards: map['hand'].length,
      isk: map['isk'],
    );
  }

  String toJson() => json.encode(toMap());

  static Player fromJson(String source) => fromMap(json.decode(source));
}

class PlayerAction {
  Player player;
  CardAction action;
}
