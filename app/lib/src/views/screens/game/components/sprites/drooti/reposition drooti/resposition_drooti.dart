import 'package:app/helper/amount_in_percentage.dart';
import 'package:app/helper/percentage_in_amount.dart';

import '../../../../../../../core/entities/properties/position.dart';

class RespositionDrooti {
  RespositionDrooti();

  Position positionOnGameResize({
    required double drootiX,
    required double drootiY,
    required double gameHeight,
    required double newGameHeight,
    required double gameWidth,
    required double newGameWidth,
  }) {
    return Position(
        x: _xNewPosition(drootiX, gameWidth, newGameWidth),
        y: _yNewPosition(drootiY, gameHeight, newGameHeight));
  }

  double _xNewPosition(double drootiX, double gameWidth, double newGameWidth) {
    double atScreenPercentage =
        AmountInPercentage().getPercent(amount: drootiX, total: gameWidth);
    return PercentageInAmount()
        .getAmount(percent: atScreenPercentage, totalAmount: newGameWidth);
  }

  double _yNewPosition(
      double drootiY, double gameHeight, double newGameHeight) {
    double atScreenPercentage =
        AmountInPercentage().getPercent(amount: drootiY, total: gameHeight);
    return PercentageInAmount()
        .getAmount(percent: atScreenPercentage, totalAmount: newGameHeight);
  }
}
