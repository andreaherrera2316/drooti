import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone%20vitals%20subscriber/idrone_vitals_subscriber.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20manager/meter_limits_manager.dart';
import 'package:app/src/views/screens/game/presenter/igame_presenter.dart';

class ProcessDroneUpdates implements IDroneVitalsSubscriber {
  ProcessDroneUpdates({required this.presenter, required this.metersManager});
  IGamePresenter presenter;
  MainMetersManager metersManager;

  @override
  batteryAmpsCapacityUpdate(double amps) {
    presenter.setBatteryAmps(amps);
  }

  @override
  void batteryAmpsRemaningUpdate(double amps) {
    presenter.setRemainingBatteryAmps(amps);
  }

  @override
  void onBatteryHealthUpdate(double health) {
    presenter.setBatteryHealth(health);
  }

  @override
  void onBatteryPercentUpdate(double batteryPercent) {
    presenter.setBatteryPercent(batteryPercent);
  }

  @override
  void onBatteryTemperatureUpdate(int temperatureF) {
    presenter.setBatteryTemperature(temperatureF);
  }

  @override
  void onMaxSpeedUpdate(double maxMetersPerS) {
    presenter.setDroneMetersPerSec(maxMetersPerS);
    metersManager.drootiMetersPerS = maxMetersPerS;
    //todo: make sure this works
  }

  @override
  void onMotorHealthUpdate(double health) {
    presenter.setMotorHealth(health);
  }
}
