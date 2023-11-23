import 'package:app/resources/commands/ongoing_command.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20actions/idrone_actions_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20actions/create%20commands/create_drone_commands.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone%20vitals%20notifier/idrone_vitals_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/igame_manager.dart';

class DroneActionsManager extends IDroneActionsManager implements IGameManager {
  DroneActionsManager(
      {required super.drone, required int gameTempInDegreesF, this.notifier}) {
    _setUp();
  }

  IDroneVitalsNotifier? notifier;

  final List<OngoingCommand> _commands = [];

  final int _executeEvery = 1;

  @override
  void start() {
    fly();
    _startCommands();
  }

  @override
  void end() {
    stopFlying();
    _cancelCommands();
  }

  @override
  void pause() {
    drone.stopFlying();
    _cancelCommands();
  }

  @override
  void resume() {
    drone.fly();
    _startCommands();
  }

  @override
  void restart() {
    drone.reset();
  }

  @override
  void fly() {
    super.fly();
    notifier?.batteryTemperatureUpdate();
  }

  @override
  void stopFlying() {
    super.stopFlying();
    notifier?.batteryTemperatureUpdate();
  }

  @override
  void damageBattery([double amount = 1]) {
    super.damageBattery(amount);
    _onHealthUpdate();
  }

  @override
  void repairBattery([double amount = 1]) {
    super.repairBattery(amount);
    _onHealthUpdate();
  }

  @override
  void damageMotor([double amount = 1]) {
    super.damageMotor(amount);
    notifier?.motorHealthUpdate();
  }

  @override
  void repairMotor([double amount = 1]) {
    super.repairMotor(amount);
    notifier?.motorHealthUpdate();
  }

  @override
  void increaseChargeByPercent(double percent) {
    super.increaseChargeByPercent(percent);
    _onChargeUpdate();
  }

  @override
  void decreaseCharge(double amps) {
    super.decreaseCharge(amps);
    _onChargeUpdate();
  }

  void _setUp() {
    if (notifier != null) {
      notifier?.drone = drone;
    }
    _createDroneCommands();
  }

  void _createDroneCommands() {
    var createCommands = CreateDroneCommands(
        drone: drone,
        droneActions: this,
        executeEverySeconds: _executeEvery,
        onExtremeTemperature: _onExtremeTemperature);
    _commands.addAll(createCommands.getCommands);
  }

  void _startCommands() {
    for (var command in _commands) {
      command.execute();
    }
  }

  void _cancelCommands() {
    for (var command in _commands) {
      command.cancel();
    }
  }

  void _onChargeUpdate() {
    notifier?.batteryAmpsRemaningUpdate();
    notifier?.batteryPercentUpdate();
  }

  void _onHealthUpdate() {
    notifier?.batteryHealthUpdate();
    notifier?.batteryPercentUpdate();
    notifier?.batteryAmpsRemaningUpdate();
    notifier?.batteryAmpsCapacityUpdate();
  }

  _onExtremeTemperature() {
    _onHealthUpdate();
    notifier?.batteryTemperatureUpdate();
  }
}
