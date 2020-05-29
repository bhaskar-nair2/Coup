import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/action.dart';
import 'package:flutter/foundation.dart';

class Player {
  DocumentReference ref;
  String name;
  String nick;
  int cards;
  int isk;
  bool active;

  Player({
    @required this.ref,
    this.name = '',
    this.cards = 0,
    this.isk = 0,
    this.nick = '',
    this.active = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cards': cards,
      'isk': isk,
    };
  }

  static Player fromFirebase(Map<String, dynamic> map, active) {
    var name;
    var nick;

    DocumentReference ref = map["player"];
    ref.get().then((value) {
      name = value.data["name"];
      nick = value.data["nick"];
    });


    return Player(
      ref: map['player'], // playerREf
      name: name,
      cards: map['hand'].length,
      isk: map['isk'],
      nick: nick,
      active: active,
    );
  }

  String toJson() => json.encode(toMap());
}

class PlayerAction {
  Player player;
  CardAction action;
}
