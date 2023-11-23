import 'package:app/src/core/entities/drone/battery/health/battery%20dies%20notifier/battery_died_notifier.dart';

abstract class IBatteryHealth implements BatteryDiedNotifier {
  double get batteryCapacity;

  void adjustHealth([double amount = 1]);

  void reset();
}
