import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20events/boundaries/output_drone_updates.dart';
import 'package:app/src/views/screens/game/presenter/igame_presenter.dart';

class ProcessDroneEvents implements OutputDroneUpdates {
  ProcessDroneEvents({required this.presenter});
  IGamePresenter presenter;

  @override
  void droneBatteryDied() {
    presenter.droneBatteryDied();
  }

  @override
  void droneMotorBroke() {
    presenter.droneMotorBroke();
  }

  @override
  void droneOutOfPower() {
    presenter.droneOutOfPower();
  }

  @override
  void extremeCold(int belowByDegreesF) {
    presenter.droneFreezing();
  }

  @override
  void extremeColdStopped() {
    presenter.droneStoppedFreezing();
  }

  @override
  void overheat(int aboveByDegreesF) {
    presenter.droneOverheating();
  }

  @override
  void overheatStopped() {
    presenter.droneStoppedOverheating();
  }

  @override
  void droneExploded() {
    presenter.droneExploded();
  }

  @override
  void droneFroze() {
    presenter.droneFroze();
  }
}
