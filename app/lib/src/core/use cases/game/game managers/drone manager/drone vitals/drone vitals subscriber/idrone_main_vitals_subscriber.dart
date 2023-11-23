abstract class IDroneMainVitalsSubscriber {
  void onMotorHealthUpdate(double health);
  void onBatteryHealthUpdate(double health);
  void onBatteryPercentUpdate(double batteryPercent);
}
