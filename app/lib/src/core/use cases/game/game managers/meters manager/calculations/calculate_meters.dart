import 'package:app/helper/amount_in_percentage.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meters_limit.dart';

class CalculateMeters {
  double drootiAtScreenPercent(double drootiY, double gameHeight) {
    return AmountInPercentage().getPercent(amount: drootiY, total: gameHeight);
  }

  double metersBelowDrooti(double totalMeters, double drootiAtPercent) {
    return totalMeters * drootiAtPercent / 100;
  }

  double metersAboveDrooti(double totalMeters, double drootiAtPercent) {
    double percentageAbove = 100 - drootiAtPercent;
    return totalMeters * percentageAbove / 100;
  }

  double metersTravelledWithinScreen(
      double drootiAtPercent, double metersInScreen,
      [double bottomLimit = 0]) {
    double metersTravelled = metersInScreen * drootiAtPercent / 100;
    bool bottomLimitIsNegative = bottomLimit < 0;
    if (bottomLimitIsNegative) {
      metersTravelled += bottomLimit;
    }
    return metersTravelled;
  }

  MeterLimits readjustLimitsAroundDrooti(double drootiAtPercent,
      double drootiAtMeters, double metersInScreen, double pixelsPerMeter) {
    double below = metersBelowDrooti(metersInScreen, drootiAtPercent);
    double above = metersAboveDrooti(metersInScreen, drootiAtPercent);

    double bottom = drootiAtMeters - below;
    double top = drootiAtMeters + above;

    return MeterLimits(
        top: top, bottom: bottom, pixelsPerMeter: pixelsPerMeter);
  }
}
