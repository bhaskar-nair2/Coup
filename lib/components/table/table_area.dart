import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/firebase/game_table.dart';
import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:provider/provider.dart';

class TableArea extends StatelessWidget {
  const TableArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double tableSize = MediaQuery.of(context).size.width - 50;
    return SizedBox.expand(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffffff),
              Color(0xffffff),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            overflow: Overflow.clip,
            children: [
              Positioned(
                bottom: (MediaQuery.of(context).size.height - tableSize) - 50,
                left: (MediaQuery.of(context).size.width - tableSize) / 2,
                child: SizedBox(
                  height: tableSize,
                  width: tableSize,
                  child: ClipPolygon(
                    sides: 6,
                    borderRadius: 5.0,
                    rotate: 90.0,
                    child: Container(
                      color: Color(0xffFFB2B2),
                      child: Center(
                        child: PlayersData(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayersData extends StatelessWidget {
  PlayersData({Key key}) : super(key: key);

  final Firestore _db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    final _table = Provider.of<GameTable>(context);

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(40),
      child: _table != null
          ? Container(
              child: Column(
                children: _table.players.map((player) {
                  return StreamBuilder(
                    stream: _db
                        .collection('players')
                        .document(player.playerId)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData)
                        return Text(
                            "${snapshot.data["nick"]}, ${snapshot.data["cards"]}, ${snapshot.data["isk"]}");
                      else
                        return Text("Loading..");
                    },
                  );
                }).toList(),
              ),
            )
          : Text("Loading"),
    );
  }
}
