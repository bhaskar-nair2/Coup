import 'package:coup/modals/firebase/fbModels.dart';
import 'package:coup/services/table_service.dart';
import 'package:coup/services/types.dart';

class Global {
  // App Data
  static final String title = 'Fireship';

  // Services
  // static final FirebaseAnalytics analytics = FirebaseAnalytics();

  // Data Models
  static final Map models = {
    SelfPlayer: (data) => SelfPlayer.fromFirestore(data),
    GameTable: (data) => GameTable.fromFirestore(data),
    Turn: (data) => Turn.fromFirestore(data),
    Player: (data) => Player.fromFirestore(data)
  };

  // Firestore References for Writes
  static final UserData<SelfPlayer> selfRef =
      UserData<SelfPlayer>(collection: 'players');
  static final TableService tableref = TableService();
  // static final
}
