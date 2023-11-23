abstract class IDroneActions {
  void fly();
  void stopFlying();
  void damageBattery([double amount = 1]);
  void repairBattery([double amount = 1]);
  void damageMotor([double amount = 1]);
  void repairMotor([double amount = 1]);
  void increaseChargeByPercent(double percent);
  void decreaseCharge(double amps);
}
