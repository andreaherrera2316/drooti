class GameViewModel {
  GameViewModel({
    this.error = false,
    this.gameStarted = false,
    this.gameOver = false,
    this.showScore = false,
    this.showContinueOrEndGame = false,
    this.maxMetersPerSec = 0,
    this.metersTravelled = 0,
    this.batteryPercent = 0,
    this.batteryAmps = 0,
    this.remainingBatteryAmps = 0,
    this.batteryHealth = 0,
    this.motorHealth = 0,
    this.batteryTemperatureF = 0,
    this.gameTemperatureF = 0,
  });

  bool error;
  bool gameStarted;
  bool gameOver;
  bool showScore;
  bool showContinueOrEndGame;
  double maxMetersPerSec;
  double metersTravelled;
  double batteryPercent;
  double batteryAmps;
  double remainingBatteryAmps;
  double batteryHealth;
  double motorHealth;
  int batteryTemperatureF;
  int gameTemperatureF;
}
