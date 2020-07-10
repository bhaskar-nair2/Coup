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
}
