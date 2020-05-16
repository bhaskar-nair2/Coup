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
}
