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
}
