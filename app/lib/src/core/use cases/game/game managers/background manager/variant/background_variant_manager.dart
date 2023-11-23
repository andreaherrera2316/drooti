import 'dart:math';

import 'package:app/src/core/entities/background/background_data.dart';
import 'package:app/src/core/entities/background/igame_background.dart';
import 'package:app/src/core/use%20cases/background/game%20backgrounds/game_backgrounds.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/background%20manager/variant/ibackground_variant_manager.dart';

class BackgroundVariantManager implements IBackgroundVariantManager {
  BackgroundVariantManager(this.background) {
    _currentVariant = _getBackgorundVariant();
  }

  @override
  BackgroundData get selectedVariant => _currentVariant;

  IGameBackground background;

  late BackgroundData _currentVariant;

  void setNewVariant() {
    _currentVariant = _getBackgorundVariant();
  }

  BackgroundData _getBackgorundVariant() {
    var variants = background.backgroundVariants;
    int wildIndex = variants.indexOf(background.wildcard);

    var random = Random();

    bool wildcard = random.nextInt(10) == 9;
    if (wildcard && wildIndex != -1) {
      return variants[wildIndex];
    }

    var variantIndex = random.nextInt(variants.length - 1);
    if (variantIndex == wildIndex) {
      if (wildIndex == 0) {
        variantIndex++;
      } else {
        variantIndex--;
      }
    }
    return variants[variantIndex];
  }
}
