import 'package:flutter_test/flutter_test.dart';
import 'package:app/src/core/entities/game/weather/temperature.dart';
import '../../../../../entities/drone/test_drone.dart';
import 'drone_game_events_mock.dart';
import 'output_drone_updates_mock.dart';

void main() {
  test('subscribeToDrone should subscribe to motor and battery events', () {
    var drone = TestDrone().drone;
    final outputMock = OutputDroneUpdatesMock();
    final droneGameEvents = DroneGameEventsMock(
      output: outputMock,
      minTempResitance: 0,
      maxTempResitance: 0,
    );

    droneGameEvents.subscribeToDrone(drone);

    drone.adjustBatteryHealth(-100);
    drone.adjustMotorHealth(-100);
    expect(outputMock.droneBatteryDiedCalled, true);
    expect(outputMock.droneMotorBrokeCalled, true);
  });

  test('onBatteryDeath should call droneBatteryDied and onDroneDied', () {
    final outputMock = OutputDroneUpdatesMock();
    final droneGameEvents = DroneGameEventsMock(
      output: outputMock,
      minTempResitance: 0,
      maxTempResitance: 0,
    );

    droneGameEvents.onBatteryDeath();
    expect(outputMock.droneBatteryDiedCalled, true);
    expect(droneGameEvents.onDroneDiedCalled, true);
  });

  test('onMotorBroke should call droneMotorBroke and onDroneDied', () {
    final outputMock = OutputDroneUpdatesMock();
    final droneGameEvents = DroneGameEventsMock(
      output: outputMock,
      minTempResitance: 0,
      maxTempResitance: 0,
    );

    droneGameEvents.onMotorBroke();

    expect(outputMock.droneMotorBrokeCalled, true);
    expect(droneGameEvents.onDroneDiedCalled, true);
  });

  test('onOutOfPower should call droneOutOfPower and onDroneDied', () {
    final outputMock = OutputDroneUpdatesMock();
    final droneGameEvents = DroneGameEventsMock(
      output: outputMock,
      minTempResitance: 0,
      maxTempResitance: 0,
    );

    droneGameEvents.onOutOfPower();

    expect(outputMock.droneOutOfPowerCalled, true);
    expect(droneGameEvents.onDroneDiedCalled, true);
  });

  test('onOverheatStopped should call overheatStopped', () {
    final outputMock = OutputDroneUpdatesMock();
    final droneGameEvents = DroneGameEventsMock(
      output: outputMock,
      minTempResitance: 0,
      maxTempResitance: 0,
    );

    droneGameEvents.onOverheatStopped(Temperature(0));

    expect(outputMock.overheatStoppedCalled, true);
  });

  test('onExtremeColdStopped should call extremeColdStopped', () {
    final outputMock = OutputDroneUpdatesMock();
    final droneGameEvents = DroneGameEventsMock(
      output: outputMock,
      minTempResitance: 0,
      maxTempResitance: 0,
    );

    droneGameEvents.onExtremeColdStopped(Temperature(80));

    expect(outputMock.extremeColdStoppedCalled, true);
  });

  test(
      'onOverheat should call overheat and _ifHotTooLongExplodeDrone if not too hot',
      () {
    final outputMock = OutputDroneUpdatesMock();
    final droneGameEvents = DroneGameEventsMock(
      output: outputMock,
      minTempResitance: 0,
      maxTempResitance: 0,
    );
    droneGameEvents.overheating = false;

    droneGameEvents.onOverheat(Temperature(0), 0);

    expect(outputMock.overheatCalled, true);
    expect(droneGameEvents.overheating, true);
  });

  test('onOverheat should call overheat and _explodeDrone if too hot', () {
    final outputMock = OutputDroneUpdatesMock();
    final droneGameEvents = DroneGameEventsMock(
      output: outputMock,
      minTempResitance: 0,
      maxTempResitance: 0,
    );
    droneGameEvents.overheating = false;

    droneGameEvents.onOverheat(Temperature(0), 10);

    expect(outputMock.overheatCalled, true);
    expect(droneGameEvents.overheating, true);
    Future.delayed(const Duration(seconds: 10), () {
      expect(outputMock.droneExplodedCalled, true);
    });
  });

  test(
      'onExtremeCold should call extremeCold and _ifColdTooLongFreezeDrone if not too cold',
      () {
    final outputMock = OutputDroneUpdatesMock();
    final droneGameEvents = DroneGameEventsMock(
      output: outputMock,
      minTempResitance: 0,
      maxTempResitance: 0,
    );
    droneGameEvents.freezing = false;

    droneGameEvents.onExtremeCold(Temperature(0), 0);

    expect(outputMock.extremeColdCalled, true);
    expect(droneGameEvents.freezing, true);
  });

  test('onExtremeCold should call extremeCold and _freezeDrone if too cold',
      () {
    final outputMock = OutputDroneUpdatesMock();
    final droneGameEvents = DroneGameEventsMock(
      output: outputMock,
      minTempResitance: 0,
      maxTempResitance: 0,
    );
    droneGameEvents.freezing = false;

    droneGameEvents.onExtremeCold(Temperature(0), 10);

    expect(outputMock.extremeColdCalled, true);
    expect(droneGameEvents.freezing, true);

    Future.delayed(const Duration(seconds: 10), () {
      expect(outputMock.droneFrozeCalled, true);
    });
  });

  test('unsubscribeToDrone should unsubscribe from motor and battery events',
      () {
    var drone = TestDrone().drone;
    final outputMock = OutputDroneUpdatesMock();
    final droneGameEvents = DroneGameEventsMock(
      output: outputMock,
      minTempResitance: 0,
      maxTempResitance: 0,
    );

    droneGameEvents.subscribeToDrone(drone);

    drone.adjustBatteryHealth(-100);
    expect(outputMock.droneBatteryDiedCalled, true);

    droneGameEvents.unsubscribeToDrone(drone);
    drone.adjustMotorHealth(-100);
    expect(outputMock.droneMotorBrokeCalled, false);
  });
}


//okay fix the tests, check them all
//and write the missing ones
//it will take you about 10 mintues 
//to get tests for a file 
//be sure to give chatgtp all of the information it needs
//and you will be done asap
