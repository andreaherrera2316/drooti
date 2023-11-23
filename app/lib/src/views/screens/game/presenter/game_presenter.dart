import 'package:app/src/views/screens/game/presenter/igame_presenter.dart';
import 'package:app/src/views/screens/game/view/igame_view.dart';

class GamePresenter implements IGamePresenter {
  GamePresenter({required this.view});
  IGameView view;

  @override
  void displayErrorScreen() {
    view.viewModel.error = true;
  }

  @override
  void start() {
    view.viewModel.gameStarted = true;
    view.updateGameData();
  }

  @override
  void end() {
    // TODO: implement end
  }

  @override
  void pause() {
    // TODO: implement pause
  }

  @override
  void restart() {
    // TODO: implement reset
  }

  @override
  void resume() {
    // TODO: implement resumeP
  }

  @override
  void setBatteryAmps(double amps) {
    view.viewModel.batteryAmps = amps;
    view.updateGameData();
  }

  @override
  void setBatteryHealth(double health) {
    view.viewModel.batteryHealth = health;
    view.updateGameData();
  }

  @override
  void setBatteryPercent(double percent) {
    view.viewModel.batteryPercent = percent;
    view.updateGameData();
  }

  @override
  void setBatteryTemperature(int temperatureF) {
    view.viewModel.batteryTemperatureF = temperatureF;
    view.updateGameData();
  }

  @override
  void setGameTemperature(int temperatureF) {
    view.viewModel.gameTemperatureF = temperatureF;
    view.updateGameData();
  }

  @override
  void setMotorHealth(double health) {
    view.viewModel.motorHealth = health;
    view.updateGameData();
  }

  @override
  void setRemainingBatteryAmps(double amps) {
    view.viewModel.remainingBatteryAmps = amps;
    view.updateGameData();
  }

  @override
  void setDroneMetersPerSec(double metersPerS) {
    view.viewModel.maxMetersPerSec = metersPerS;
    view.updateGameData();
  }

  @override
  void setMetersTravelled(double meters) {
    view.viewModel.metersTravelled = meters;
    view.updateGameData();
  }

  @override
  void droneExploded() {
    view.explodeDrone();
  }

  @override
  void droneFreezing() {
    view.droneFreezing();
  }

  @override
  void droneFroze() {
    view.freezeDrone();
  }

  @override
  void droneOverheating() {
    view.droneOverheating();
  }

  @override
  void droneStoppedFreezing() {
    view.droneStoppedFreezing();
  }

  @override
  void droneStoppedOverheating() {
    view.droneStopedOverheating();
  }

  @override
  void droneBatteryDied() {
    view.droneBatteryDied();
  }

  @override
  void droneMotorBroke() {
    view.droneMotorBroke();
  }

  @override
  void droneOutOfPower() {
    view.droneOutOfPower();
  }

  @override
  void autumn() {
    view.autumn();
  }

  @override
  void spring() {
    view.spring();
  }

  @override
  void summer() {
    view.summer();
  }

  @override
  void winter() {
    view.winter();
  }

  @override
  void updateBgVariant(String variant, int color) {
    view.updateBgVariant(variant, color);
  }
}
