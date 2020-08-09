import 'package:coup/data/actions/action_enums.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/player.dart';
import 'package:coup/modals/firebase/turn.dart';
import 'package:coup/repos/firebase/commons.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TurnConsumer {
  List<Player> playerList;
  static String hash;

  static readTurn(Turn turn) async {
    var state = turn.gameState;

    if (turn.hash.toString() == hash.toString()) {
      print('${turn.hash.toString()} ${hash.toString()}');
      return;
    } else
      hash = turn.hash;

    // if (turn.block != null) {
    // } else

    if (turn.action.type != null) {
      var type = turn.action.type.action;
      var player = turn.action.player;

      if (player == IDManager.selfId)
        switch (type) {
          case ActionName.income:
            FirebaseCommons.updateIsk(1);
            await FirebaseCommons.changeTurn();
            break;
          case ActionName.aid:
            // if action
            // set state
            if (turn.block != null) {
              print(turn.block);
              // set state
            }
            // set state
            break;
          case ActionName.coup:
          case ActionName.tax:
          case ActionName.assassinate:
          case ActionName.steal:
          case ActionName.exchange:
            break;
          default:
            print(type);
        }
      else
        switch (type) {
          case ActionName.income:
            Fluttertoast.showToast(msg: '$player has taken Income'); // todo
            break;
          case ActionName.aid:
            Fluttertoast.showToast(
                msg: '$player is taking Foreign Aid'); // todo
            // set state
            break;
          case ActionName.coup:
            Fluttertoast.showToast(
                msg: '$player has called a Coup on effectedPlayer!'); // todo
            // set state
            break;
        }
    }
  }
  // player was self and state is play
}
