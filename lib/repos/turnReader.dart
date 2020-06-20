import 'package:coup/firebase/firedb.dart';
import 'package:coup/modals/firebase/player.dart';
import 'package:coup/modals/firebase/turn.dart';
import 'package:coup/modals/game/action.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TurnReader {
  List<Player> playerList;
    
  // setupData() async{
  //   var tableData = await FireDB.tableStream(tableId);
  // }

  static readTurn(Turn turn) {
    var type = turn.action.action;
    // PlayersList plList = PlayersList();
    // var player = plList.getById(turn.action.player);

    switch (type) {
      case ActionName.income:
        Fluttertoast.showToast(msg: 'Income Taken');
        break;
      default:
        print('default');
    }
  }
}
