import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/calculations/calculate_meters.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meters_limit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final calc = CalculateMeters();

  //READJUST LIMITS AROUND DROOTI
  test(
      "Test readjusting the limits, when drooti is at 0 meters and at 0% of the screen ",
      () {
    double drootiAtMeters = 0;
    double drootiAtPercent = 0;
    double metersInNewScreen = 1000;
    MeterLimits limits = calc.readjustLimitsAroundDrooti(
        drootiAtPercent, drootiAtMeters, metersInNewScreen, 10);

    expect(limits.top, 1000);
    expect(limits.bottom, 0);
  });

  test(
      "Test readjusting the limits, when drooti is at 0 meters and at 50% of the screen ",
      () {
    double drootiAtMeters = 0;
    double drootiAtPercent = 50;
    double metersInNewScreen = 1000;
    MeterLimits limits = calc.readjustLimitsAroundDrooti(
        drootiAtPercent, drootiAtMeters, metersInNewScreen, 10);

    expect(limits.top, 500);
    expect(limits.bottom, -500);
  });

  test(
      "Test readjusting the limits, when drooti is at 100 meters and at 50% of the screen ",
      () {
    double drootiAtMeters = 100;
    double drootiAtPercent = 50;
    double metersInScreen = 1000;
    MeterLimits limits = calc.readjustLimitsAroundDrooti(
        drootiAtPercent, drootiAtMeters, metersInScreen, 10);

    expect(limits.top, 600);
    expect(limits.bottom, -400);
  });

  test(
      "Test readjusting the limits, when drooti is at 1000 meters and at 50% of the screen ",
      () {
    double drootiAtMeters = 1000;
    double drootiAtPercent = 50;
    double metersInNewScreen = 1000;
    MeterLimits limits = calc.readjustLimitsAroundDrooti(
        drootiAtPercent, drootiAtMeters, metersInNewScreen, 10);

    expect(limits.top, 1500);
    expect(limits.bottom, 500);
  });

  //METERS TRAVELLED WITHIN SCREEN
  test(
      "Check how many meters drooti has travelled within the screen when, the bottom limit is 0 and drooti is at 50%",
      () {
    double drootiAtPercent = 50;
    double metersInScreen = 1000;
    double bottomLimit = 100;
    var result = calc.metersTravelledWithinScreen(
        drootiAtPercent, metersInScreen, bottomLimit);

    expect(result, 500);
  });

  test(
      "Check how many meters drooti has travelled within the screen when, the bottom limit is not 0 and drooti is at 30%",
      () {
    double drootiAtPercent = 30;
    double metersInScreen = 1000;
    double bottomLimit = 100;
    var result = calc.metersTravelledWithinScreen(
        drootiAtPercent, metersInScreen, bottomLimit);

    expect(result, 300);
  });

  test(
      "Check how many meters drooti has travelled within the screen when, the bottom limit is negative and drooti is at 70%",
      () {
    double drootiAtPercent = 70;
    double metersInScreen = 1000;
    double bottomLimit = -100;
    var result = calc.metersTravelledWithinScreen(
        drootiAtPercent, metersInScreen, bottomLimit);

    expect(result, 600);
  });

  //DROOTI AT SCREEN PERCENT
  test("Drooti Screen Percent, when drooti is at 0% of the screen", () {
    double gameHeight = 1200;
    double drootiY = 0;
    var result = calc.drootiAtScreenPercent(drootiY, gameHeight);

    expect(result, 0);
  });

  test("Drooti Screen Percent, when drooti is at 37% of the screen", () {
    double gameHeight = 1200;
    double drootiY = gameHeight * 0.37;
    var result = calc.drootiAtScreenPercent(drootiY, gameHeight);

    expect(result, 37);
  });

  test("Drooti Screen Percent, when drooti is at 68% of the screen", () {
    double gameHeight = 1200;
    double drootiY = gameHeight * 0.68;
    var result = calc.drootiAtScreenPercent(drootiY, gameHeight);

    expect(result, 68);
  });

  test("Drooti Screen Percent, when drooti is at 100% of the screen", () {
    double gameHeight = 1200;
    double drootiY = gameHeight;
    var result = calc.drootiAtScreenPercent(drootiY, gameHeight);

    expect(result, 100);
  });

  //METERS BELOW DROOTI
  test("test meters below drooti, when drooti is at 0%", () {
    double totalMeters = 1000;
    double drootiAtPercentage = 0;
    var result = calc.metersBelowDrooti(totalMeters, drootiAtPercentage);

    expect(result, 0);
  });
  test("test meters below drooti, when drooti is at 25%", () {
    double totalMeters = 1000;
    double drootiAtPercentage = 25;
    var result = calc.metersBelowDrooti(totalMeters, drootiAtPercentage);

    expect(result, 250);
  });

  test("test meters below drooti, when drooti is at 50%", () {
    double totalMeters = 1000;
    double drootiAtPercentage = 50;
    var result = calc.metersBelowDrooti(totalMeters, drootiAtPercentage);

    expect(result, 500);
  });

  test("test meters below drooti, when drooti is at 75%", () {
    double totalMeters = 1000;
    double drootiAtPercentage = 75;
    var result = calc.metersBelowDrooti(totalMeters, drootiAtPercentage);

    expect(result, 750);
  });

  test("test meters below drooti, when drooti is at 100%", () {
    double totalMeters = 1000;
    double drootiAtPercentage = 100;
    var result = calc.metersBelowDrooti(totalMeters, drootiAtPercentage);

    expect(result, 1000);
  });

  //METERS ABOVE DROOTI
  test("test meters above drooti, when drooti is at 0%", () {
    double totalMeters = 1000;
    double drootiAtPercentage = 0;
    var result = calc.metersAboveDrooti(totalMeters, drootiAtPercentage);

    expect(result, 1000);
  });
  test("test meters above drooti, when drooti is at 25%", () {
    double totalMeters = 1000;
    double drootiAtPercentage = 25;
    var result = calc.metersAboveDrooti(totalMeters, drootiAtPercentage);

    expect(result, 750);
  });

  test("test meters above drooti, when drooti is at 50%", () {
    double totalMeters = 1000;
    double drootiAtPercentage = 50;
    var result = calc.metersAboveDrooti(totalMeters, drootiAtPercentage);

    expect(result, 500);
  });

  test("test meters above drooti, when drooti is at 75%", () {
    double totalMeters = 1000;
    double drootiAtPercentage = 75;
    var result = calc.metersAboveDrooti(totalMeters, drootiAtPercentage);

    expect(result, 250);
  });

  test("test meters above drooti, when drooti is at 100%", () {
    double totalMeters = 1000;
    double drootiAtPercentage = 100;
    var result = calc.metersAboveDrooti(totalMeters, drootiAtPercentage);

    expect(result, 0);
  });
}
