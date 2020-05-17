import 'package:coup/modals/move.dart';
import 'package:coup/repos/action_functions.dart';

enum CardAction { tax, assassinate, exchange, steal, none }

extension CardActionExtension on CardAction {
  String get description {
    switch (this) {
      case CardAction.tax:
        return "Take Tax";

      case CardAction.assassinate:
        return "Assassinate";

      case CardAction.exchange:
        return "Swap Card";

      case CardAction.steal:
        return "Steal ISK";

      case CardAction.none:
        return null;

      default:
        return 'err';
    }
  }

  Move get instance {
    switch (this) {
      case CardAction.tax:
        return tax;

      case CardAction.assassinate:
        return assassinate;

      case CardAction.exchange:
        return exchange;

      case CardAction.steal:
        return steal;

      case CardAction.none:
        return Move.none();

      default:
        return Move.none();
    }
  }
}
