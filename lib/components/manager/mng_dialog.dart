import 'package:coup/components/base/base_load_btn.dart';
import 'package:coup/firebase/callers.dart';
import 'package:coup/services/firedb.dart';
import 'package:coup/modals/firebase/game_table.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class TableManagerDialog extends StatefulWidget {
  const TableManagerDialog({Key key}) : super(key: key);

  @override
  _TableManagerDialogState createState() => _TableManagerDialogState();
}

class _TableManagerDialogState extends State<TableManagerDialog> {
  final minPlayers = 2;
  bool loading = false;

  toggleLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _table = Provider.of<GameTable>(context);
    var isOwner = _table.owner == IDManager.selfId;
    var hasMin = _table.players.length <= minPlayers;
    var _players = _table.players;

    startGame() async {
      toggleLoading();
      Fluttertoast.showToast(
        msg: "Starting Game",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.green,
        fontSize: 12.0,
      );
      try {
        await FirebaseCallers.startGame();
      } on PlatformException catch (error) {
        Fluttertoast.showToast(
          msg: "Unable to Start Game: ${error.message}",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.red,
          fontSize: 12.0,
        );
      } catch (error) {
        print("error");
        Fluttertoast.showToast(
          msg: "Unable to Start Game",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.red,
          fontSize: 12.0,
        );
      } finally {
        toggleLoading();
      }
    }

    leave() async {
      Fluttertoast.showToast(msg: "Leaving Table");
      try {
        await FirebaseCallers.leaveTable();
        IDManager.tableId = '';
        Navigator.of(context).pushReplacementNamed('/home-screen');
      } catch (error) {
        print("Leave Table Error: $error");
      }
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
            BaseLoadBtn(
              text: isOwner ? 'Start Game' : "Waiting to Start",
              isLoading: loading,
              color: isOwner ? Colors.greenAccent : Colors.grey,
              height: 30,
              action: isOwner
                  ? () {
                      if (!hasMin)
                        Fluttertoast.showToast(
                            msg: '$minPlayers Required to start game');
                      else
                        startGame();
                    }
                  : null,
            ),
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
  const PLayerDataMaker(this.playerId, {Key key}) : super(key: key);

  final String playerId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // chnage this to a player builder stream
      stream: FireDB.playerStream(playerId),
      builder: (context, AsyncSnapshot<Player> snapshot) {
        if (snapshot.hasData) {
          Player player = snapshot.data;
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: IDManager.selfId != playerId
                    ? Icon(Icons.cancel)
                    : Icon(Icons.verified_user, color: Colors.green),
                onPressed: IDManager.selfId != playerId
                    ? () {
                        print(playerId);
                        print(IDManager.selfId);
                      }
                    : null,
                color: Colors.redAccent,
                disabledColor: Colors.grey,
              ),
              SizedBox(
                child: Text(
                  "${player.nick}",
                  style: TextStyle(fontSize: 14),
                ),
              )
            ],
          );
        } else
          return Text("Loading..");
      },
    );
  }
}
