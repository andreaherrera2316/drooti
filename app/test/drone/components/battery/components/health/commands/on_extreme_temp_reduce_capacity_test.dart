import 'dart:async';

import 'package:app/src/core/entities/drone/battery/health/commands/on_extreme_temp_reduce_capacity.dart';

import 'package:app/src/core/entities/game/weather/temperature.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../src/game rules/entities/drone/test_drone_actions.dart';

void main() {
  test(
      "Only reduces educes health battery capacity when there's an extreme temperature",
      () {
    var droneActions = TestDroneActions();
    var command = OnExtremeTempReduceCapacity(droneActions: droneActions);
    command.execute();
    expect(droneActions.damagedBattery, false);
  });

  test("Reduces health battery capacity  while extreme cold", () {
    var droneActions = TestDroneActions();
    var command = OnExtremeTempReduceCapacity(droneActions: droneActions);
    command.onExtremeCold(Temperature.zero, 0);
    Timer(const Duration(minutes: 1), () {
      expect(droneActions.damagedBattery, true);
    });
  });

  test("Reduces health battery capacity  while overheat", () {
    var droneActions = TestDroneActions();
    var command = OnExtremeTempReduceCapacity(droneActions: droneActions);
    command.onOverheat(Temperature.zero, 0);
    Timer(const Duration(minutes: 1), () {
      expect(droneActions.damagedBattery, true);
      command.onOverheatStopped(Temperature.zero);
    });
  });
}
