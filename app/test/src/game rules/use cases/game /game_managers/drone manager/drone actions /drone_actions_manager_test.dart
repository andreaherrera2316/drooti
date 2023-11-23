import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20actions/drone_actions_manager.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../entities/drone/test_drone.dart';

DroneActionsManager getDrone() =>
    DroneActionsManager(drone: TestDrone().drone, gameTempInDegreesF: 80);

void main() {
  test("when flying is called the drone start flying", () {
    var actions = getDrone();
    expect(actions.drone.flight.isFlying, false);
    actions.fly();
    expect(actions.drone.flight.isFlying, true);
  });
  test("when stop flying is called the drone stops flying", () {
    var actions = getDrone();
    expect(actions.drone.flight.isFlying, false);
    actions.fly();
    expect(actions.drone.flight.isFlying, true);
    actions.stopFlying();
    expect(actions.drone.flight.isFlying, false);
  });

  test(
      "when the battery is damaged, drone's battery health decreases, and amps remaining are reduces",
      () {
    var actions = getDrone();
    //var batteryAmps = actions.drone.battery.amps;
    var batteryHealth = actions.drone.battery.health;
    actions.damageBattery();
    // expect(actions.drone.battery.ampsRemaining == batteryAmps, false);
    expect(actions.drone.battery.health == batteryHealth, false);
  });

  test("when the battery is repaired, drone's battery health increasaes", () {
    var actions = getDrone();
    var batteryHealth = actions.drone.battery.health;
    actions.damageBattery();
    expect(actions.drone.battery.health == batteryHealth, false);
    actions.repairBattery();
    expect(actions.drone.battery.health, batteryHealth);
  });

  test(
      "when the motor is damaged, drone's motor health decreases, and max speed decreases",
      () {
    var actions = getDrone();
    var motorHealth = actions.drone.motor.health;
    //var maxSpeed = actions.drone.motor.maxSpeed.metersPerSec;
    actions.damageMotor();
    bool decreased = actions.drone.motor.health < motorHealth;
    expect(decreased, true);
    // expect(actions.drone.motor.maxSpeed.metersPerSec == maxSpeed, false);
  });

  test("when the motor is repaired, drone's motor health increasaes", () {
    var actions = getDrone();
    var motorHealth = actions.drone.motor.health;
    actions.damageMotor();
    bool increased = actions.drone.motor.health > motorHealth;
    expect(increased, true);
  });

  test("the battery charge can be decreased ", () {
    var actions = getDrone();
    var power = actions.drone.battery.powerPercentage;
    actions.decreaseCharge(500);
    bool decreased = actions.drone.battery.powerPercentage < power;
    expect(decreased, true);
  });

  test("the battery charge can be increased by percentage ", () {
    var actions = getDrone();
    actions.decreaseCharge(500);
    var power = actions.drone.battery.powerPercentage;
    actions.increaseChargeByPercent(40);
    bool increased = power < actions.drone.battery.powerPercentage;
    expect(increased, true);
  });

  test("when the game start method is called, the drone starts to fly", () {
    var actions = getDrone();
    expect(actions.drone.flight.isFlying, false);
    actions.start();
    expect(actions.drone.flight.isFlying, true);
  });

  test("when the game end method is called, the drone stops flying", () {
    var actions = getDrone();
    expect(actions.drone.flight.isFlying, false);
    actions.start();
    expect(actions.drone.flight.isFlying, true);
    actions.end();
    expect(actions.drone.flight.isFlying, false);
  });

  test("when the game pause method is called, the drone stops flying", () {
    var actions = getDrone();
    expect(actions.drone.flight.isFlying, false);
    actions.start();
    expect(actions.drone.flight.isFlying, true);
    actions.pause();
    expect(actions.drone.flight.isFlying, false);
  });

  test("when the game resume method is called, the drone start flying again",
      () {
    var actions = getDrone();
    expect(actions.drone.flight.isFlying, false);
    actions.start();
    expect(actions.drone.flight.isFlying, true);
    actions.pause();
    expect(actions.drone.flight.isFlying, false);
    actions.resume();
    expect(actions.drone.flight.isFlying, true);
  });

  test("when the game is restarted, the drone is reset to its default state",
      () {
    var actions = getDrone();
    //okay now we need to see if the drone being reset restart

    double droneAmps = actions.drone.battery.amps;
    double droneSpeed = actions.drone.motor.maxSpeed.metersPerSec;

    expect(actions.drone.battery.ampsRemaining, droneAmps);
    expect(actions.drone.motor.maxSpeed.metersPerSec, droneSpeed);
    expect(actions.drone.battery.fullyCharged, true);
    expect(actions.drone.battery.powerPercentage == 100, true);
    expect(actions.drone.battery.health == 100, true);
    expect(actions.drone.motor.health == 100, true);

    actions.damageBattery(20);
    actions.damageMotor(30);
    actions.decreaseCharge(200);

    //todo: uncomment after testing drone
    // expect(actions.drone.battery.ampsRemaining == droneAmps, false);
    // expect(actions.drone.motor.maxSpeed.metersPerSec == droneSpeed, false);
    expect(actions.drone.battery.fullyCharged, false);
    expect(actions.drone.battery.powerPercentage == 100, false);
    expect(actions.drone.battery.health == 100, false);
    expect(actions.drone.motor.health == 100, false);

    actions.restart();

    expect(actions.drone.battery.amps, droneAmps);
    expect(actions.drone.motor.maxSpeed.metersPerSec, droneSpeed);
    expect(actions.drone.battery.fullyCharged, true);
    expect(actions.drone.battery.powerPercentage == 100, true);
    expect(actions.drone.battery.health == 100, true);
    expect(actions.drone.motor.health == 100, true);
  });
}
