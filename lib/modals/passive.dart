import 'package:coup/modals/move.dart';
import 'package:coup/repos/passive_functions.dart';

enum CardPassive { vengence, inheritance, treaty, none }

extension CardPassiveExtension on CardPassive {
  String get description {
    switch (this) {
      case CardPassive.vengence:
        return "Vengence";

      case CardPassive.inheritance:
        return "Inheritance";

      case CardPassive.treaty:
        return "Treaty";

      case CardPassive.none:
        return null;

      default:
        return 'err';
    }
  }

  Move get instance {
    switch (this) {
      case CardPassive.vengence:
        return vengence;

      case CardPassive.inheritance:
        return inheritance;

      case CardPassive.treaty:
        return treaty;

      case CardPassive.none:
        return Move.none();

      default:
        return Move.none();
    }
  }
}
