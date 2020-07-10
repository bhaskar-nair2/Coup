import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/player.dart';
import 'package:coup/modals/firebase/turn.dart';
import 'package:coup/modals/game/action.dart';
import 'package:coup/repos/firebase/commons.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TurnConsumer {
  List<Player> playerList;
  static String hash;

  static readTurn(Turn turn) async {
    if (turn.hash == hash)
      return;
    else
      hash = turn.hash;

    if (turn.action != null) {
      var type = turn.action.type;
      var player = turn.action.player;

      switch (type) {
        case ActionName.income:
          Fluttertoast.showToast(msg: '$player has taken Income'); // todo
          // consume
          if (player == IDManager.selfId) {
            FirebaseCommons.updateIsk(1);
            await FirebaseCommons.changeTurn();
          }
          break;
        case ActionName.aid:
          Fluttertoast.showToast(msg: '$player is taking Foreign Aid'); // todo
          // set state
          break;
        case ActionName.coup:
          Fluttertoast.showToast(
              msg: '$player has called a Coup on effectedPlayer!'); // todo
          // set state
          break;
        default:
          print('default');
      }
    }
  }
  // player was self and state is play
}
