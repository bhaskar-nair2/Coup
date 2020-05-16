enum CardAbility { block_aid, block_assassin, block_steal, limit_steal, none }

extension CardAbilityExtension on CardAbility {
  String get description {
    switch (this) {
      case CardAbility.block_aid:
        return "Block Foreign Aid";

      case CardAbility.block_assassin:
        return "Block Assasination";

      case CardAbility.block_steal:
        return "Block Stealing";

      case CardAbility.limit_steal:
        return "Limit Stealing";

      case CardAbility.none:
        return null;

      default:
        return 'err';
    }
  }
}
