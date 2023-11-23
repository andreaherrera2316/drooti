abstract class IGameActions {
  void damageBattery([double percent = 1]);
  void repairBattery([double percent = 1]);
  void damageMotor([double percent = 1]);
  void repairMotor([double percent = 1]);
  void increaseChargeByPercent(double percent);
  void adjustWeather(int amount);
}
