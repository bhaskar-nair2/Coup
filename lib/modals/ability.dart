import 'package:coup/modals/move.dart';
import 'package:coup/repos/ability_functions.dart';

enum CardAbility { blockAid, blockAssassin, blockSteal, limitSteal, none }

extension CardAbilityExtension on CardAbility {
  String get description {
    switch (this) {
      case CardAbility.blockAid:
        return "Block Foreign Aid";

      case CardAbility.blockAssassin:
        return "Block Assasination";

      case CardAbility.blockSteal:
        return "Block Stealing";

      case CardAbility.limitSteal:
        return "Limit Stealing";

      case CardAbility.none:
        return null;

      default:
        return 'err';
    }
  }

  Move get instance {
    switch (this) {
      case CardAbility.blockAid:
        return blockAid;

      case CardAbility.blockAssassin:
        return blockAssassin;

      case CardAbility.blockSteal:
        return blockSteal;

      case CardAbility.limitSteal:
        return limitSteal;

      case CardAbility.none:
        return Move.none();

      default:
        return Move.none();
    }
  }
}
