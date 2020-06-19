import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/firebase/callers.dart';
import 'package:coup/firebase/firedb.dart';
import 'package:coup/modals/firebase/game_table.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/player.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class TableManagerDialog extends StatelessWidget {
  const TableManagerDialog({Key key}) : super(key: key);
  final minPlayers = 2;

  @override
  Widget build(BuildContext context) {
    var _table = Provider.of<GameTable>(context);
    var isOwner = _table.owner == IDManager.selfId;
    var hasMin = _table.players.length <= minPlayers;
    var _players = _table.players;

    leave() async {
      Fluttertoast.showToast(
        msg: "Leaving Table",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.green,
        fontSize: 12.0,
      );
      await FirebaseCallers.leaveTable(IDManager.selfId, IDManager.tableId);
      Navigator.of(context).pushReplacementNamed('/home-screen');
    }

    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        height: 400,
        child: Column(
          children: <Widget>[
            Text('Table Pin: ${_table.pin}'),
            _players.length < minPlayers
                ? Text('Waiting for More Players...')
                : Text("Players Joined ${_players.length}/6"),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 200,
              child: Container(
                child: Column(
                  children: List.generate(
                    _players.length,
                    (index) => PLayerDataMaker(_players[index]),
                  ),
                ),
              ),
            ),
            Container(
                height: 30,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FlatButton(
                  disabledColor: Colors.grey,
                  onPressed: isOwner
                      ? () {
                          if (!hasMin)
                            Fluttertoast.showToast(
                                msg: '$minPlayers Required to start game');
                          else
                            FirebaseCallers.startGame(_table.tableId);
                        }
                      : null,
                  child:
                      isOwner ? Text('Start Game') : Text("Waiting to Start"),
                )),
            Container(
              height: 30,
              width: 250,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FlatButton(
                onPressed: leave,
                child: Text('Leave Table'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PLayerDataMaker extends StatelessWidget {
  const PLayerDataMaker(this.player, {Key key}) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // chnage this to a player builder stream
      stream: FirestoreService.playerStream(player.playerId),
      builder: (context, AsyncSnapshot<Player> snapshot) {
        if (snapshot.hasData)
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: IDManager.selfId != player.playerId
                    ? Icon(Icons.cancel)
                    : Icon(Icons.verified_user),
                onPressed: IDManager.selfId != player.playerId
                    ? () {
                        print(player.playerId);
                        print(IDManager.selfId);
                      }
                    : null,
                color: Colors.redAccent,
                disabledColor: Colors.grey,
              ),
              SizedBox(
                child: Text(
                  "${snapshot.data.name}",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        else
          return Text("Loading..");
      },
    );
  }
}
