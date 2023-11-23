import 'package:app/src/core/use%20cases/game/game%20managers/igame_manager.dart';

abstract class IGamePresenter implements IGameManager {
  void displayErrorScreen();
  void updateBgVariant(String variant, int color);

  void spring();
  void summer();
  void autumn();
  void winter();

  void setGameTemperature(int temperatureF);
  void setMetersTravelled(double meters);
  void setDroneMetersPerSec(double metersPerS);
  void setMotorHealth(double health);
  void setBatteryPercent(double percent);
  void setBatteryAmps(double amps);
  void setBatteryTemperature(int temperatureF);
  void setRemainingBatteryAmps(double amps);
  void setBatteryHealth(double health);

  void droneBatteryDied();
  void droneMotorBroke();
  void droneOutOfPower();
  void droneFreezing();
  void droneStoppedFreezing();
  void droneFroze();
  void droneOverheating();
  void droneStoppedOverheating();
  void droneExploded();
}
