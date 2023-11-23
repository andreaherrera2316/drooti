import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'ipick_background_lang_processor.dart';

class IntlPickBackgroundLangProcessor implements IPickBackgroundLangProcessor {
  IntlPickBackgroundLangProcessor(this.intl);
  AppLocalizations intl;

  @override
  String get alienWorld => intl.alienWorld;

  @override
  String get cityWorld => intl.cityWorld;

  @override
  String get easternIslandWorld => intl.easternIslandWorld;

  @override
  String get fairyTaleWorld => intl.fairyTaleWorld;

  @override
  String get farmWorld => intl.farmWorld;

  @override
  String get islandWorld => intl.islandWorld;

  @override
  String getBackgroundName(String backgroundID) {
    if (backgroundID == "alien") {
      return alienWorld;
    } else if (backgroundID == "city") {
      return cityWorld;
    } else if (backgroundID == "eastern_island") {
      return easternIslandWorld;
    } else if (backgroundID == "fairy_tale") {
      return fairyTaleWorld;
    } else if (backgroundID == "farm") {
      return farmWorld;
    } else if (backgroundID == "island") {
      return islandWorld;
    }
    return "";
  }
}
