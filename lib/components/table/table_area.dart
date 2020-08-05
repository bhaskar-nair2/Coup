import 'package:coup/modals/firebase/game_table.dart';
import 'package:coup/modals/firebase/player.dart';
import 'package:coup/services/player_service.dart';
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
                bottom: (MediaQuery.of(context).size.height - tableSize) - 60,
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

  @override
  Widget build(BuildContext context) {
    final _table = Provider.of<GameTable>(context);

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(40),
      child: _table != null
          ? Container(
              child: Column(
                  children: List.generate(
                _table.players.length,
                (index) => PLayerDataMaker(_table.players[index]),
              )),
            )
          : Text("Loading"),
    );
  }
}

class PLayerDataMaker extends StatelessWidget {
  const PLayerDataMaker(this.playerId, {Key key}) : super(key: key);

  final String playerId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // chnage this to a player builder stream
      stream: PlayerService(playerId).streamData(),
      builder: (context, AsyncSnapshot<Player> snapshot) {
        if (snapshot.hasData)
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("${snapshot.data.nick}"),
              Text("${snapshot.data.cards}"),
              Text("${snapshot.data.isk}"),
            ],
          );
        else
          return Text("Loading..");
      },
    );
  }
}
