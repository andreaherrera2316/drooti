import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20events/boundaries/output_drone_updates.dart';

class OutputDroneUpdatesMock implements OutputDroneUpdates {
  bool droneBatteryDiedCalled = false;
  bool droneMotorBrokeCalled = false;
  bool droneOutOfPowerCalled = false;
  bool overheatStoppedCalled = false;
  bool extremeColdStoppedCalled = false;
  bool overheatCalled = false;
  bool extremeColdCalled = false;
  bool droneFrozeCalled = false;
  bool droneExplodedCalled = false;

  @override
  void droneBatteryDied() {
    droneBatteryDiedCalled = true;
  }

  @override
  void droneMotorBroke() {
    droneMotorBrokeCalled = true;
  }

  @override
  void droneOutOfPower() {
    droneOutOfPowerCalled = true;
  }

  @override
  void overheatStopped() {
    overheatStoppedCalled = true;
  }

  @override
  void extremeColdStopped() {
    extremeColdStoppedCalled = true;
  }

  @override
  void overheat(int aboveByDeegresF) {
    overheatCalled = true;
  }

  @override
  void extremeCold(int belowByDegreesF) {
    extremeColdCalled = true;
  }

  @override
  void droneFroze() {
    droneFrozeCalled = true;
  }

  @override
  void droneExploded() {
    droneExplodedCalled = true;
  }
}
