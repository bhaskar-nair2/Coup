import 'package:coup/modals/game_table.dart';
import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:provider/provider.dart';

class PlayArea extends StatelessWidget {
  const PlayArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final table = Provider.of<GameTable>(context);
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
              Color(0xff092147),
              Color(0xff1a488e),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            overflow: Overflow.clip,
            children: [
              Positioned(
                top: (MediaQuery.of(context).size.height - tableSize) / 2,
                left: (MediaQuery.of(context).size.width - tableSize) / 2,
                child: SizedBox(
                  height: tableSize,
                  width: tableSize,
                  child: ClipPolygon(
                    sides: 6,
                    borderRadius: 5.0,
                    rotate: 90.0,
                    child: Container(
                      color: Color(0xff092147),
                      padding: EdgeInsets.all(40),
                      child: Center(
                        child: ClipPolygon(
                          sides: 6,
                          borderRadius: 5.0,
                          rotate: 90.0,
                          child: Container(
                            color: Color(0xff97b2de),
                            child: Center(
                              child: PlayersData(table: table),
                            ),
                          ),
                        ),
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
  const PlayersData({Key key, this.table}) : super(key: key);

  final GameTable table;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(40),
      child: table != null
          ? Table(
              border: TableBorder.all(
                width: 1,
                color: Colors.grey,
              ),
              children: table.players.map((player) {
                return TableRow(decoration: BoxDecoration(), children: [
                  Text(player.nick.toString() ?? ''),
                  Text(player.cards.toString() ?? ''),
                  Text(player.isk.toString() ?? '')
                ]);
              }).toList(),
            )
          : Text("Loading"),
    );
  }
}
