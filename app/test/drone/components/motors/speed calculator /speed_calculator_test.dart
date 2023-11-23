import 'package:app/src/core/entities/drone/motor/speed%20calculator/speed_calculator.dart';
import 'package:app/src/core/entities/drone/motor/speed/speed.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("only the percentage specified is reduced by health", () {
    double meters = 100;
    double affectedPercent = 50;
    var calculator = SpeedCalculator(
        health: 0,
        maxSpeed: Speed(metersPerSec: meters),
        affectedPercent: affectedPercent);
    calculator.maxSpeedAfterHealth;
    expect(calculator.maxSpeedAfterHealth.metersPerSec,
        meters * affectedPercent / 100);
  });

  test("health cannot be set higher than 100", () {
    double meters = 100;
    double affectedPercent = 50;
    var calculator = SpeedCalculator(
        health: 100,
        maxSpeed: Speed(metersPerSec: meters),
        affectedPercent: affectedPercent);

    var onHealth100 = calculator.maxSpeedAfterHealth.metersPerSec;
    calculator.health = 110;
    expect(calculator.maxSpeedAfterHealth.metersPerSec, onHealth100);
  });

  test("health cannot be set lower than 0", () {
    double meters = 100;
    double affectedPercent = 50;
    var calculator = SpeedCalculator(
        health: 0,
        maxSpeed: Speed(metersPerSec: meters),
        affectedPercent: affectedPercent);

    var onHealth0 = calculator.maxSpeedAfterHealth.metersPerSec;
    calculator.health = -10;
    expect(calculator.maxSpeedAfterHealth.metersPerSec, onHealth0);
  });

  test("the percent affected by health cannot be set higher than 100", () {
    double meters = 100;
    double affectedPercent = 100;
    var calculator = SpeedCalculator(
        health: 100,
        maxSpeed: Speed(metersPerSec: meters),
        affectedPercent: affectedPercent);

    var onAffected100 = calculator.maxSpeedAfterHealth.metersPerSec;
    calculator.percentAffectedByHealth = 110;
    expect(calculator.maxSpeedAfterHealth.metersPerSec, onAffected100);
  });

  test("the percent affected by health cannot be set lower than 0", () {
    double meters = 100;
    double affectedPercent = 0;
    var calculator = SpeedCalculator(
        health: 0,
        maxSpeed: Speed(metersPerSec: meters),
        affectedPercent: affectedPercent);

    var onAffected0 = calculator.maxSpeedAfterHealth.metersPerSec;
    calculator.health = -10;
    expect(calculator.maxSpeedAfterHealth.metersPerSec, onAffected0);
  });
}
