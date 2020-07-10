import 'package:coup/modals/firebase/fbModels.dart';
import 'package:coup/services/self_service.dart';
import 'package:coup/services/table_service.dart';
import 'package:coup/services/turn_service.dart';

class Global {
  // App Data
  static final String title = 'Fireship';

  // Services
  // static final FirebaseAnalytics analytics = FirebaseAnalytics();

  // Data Models
  static final Map models = {
    SelfPlayer: (data) => SelfPlayer.fromRdb(data),
    GameTable: (data) => GameTable.fromRdb(data),
    Turn: (data) => Turn.fromRdb(data),
    Player: (data) => Player.fromRdb(data)
  };

  // Firestore References for Writes
  static final UserData<SelfPlayer> selfRef =
      UserData<SelfPlayer>(collection: 'players');
  static final TableService tableref = TableService();
  static final TurnService turnRef = TurnService();
  // static final
}
