import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/extreme_temperature_subscriber.dart';

abstract class ExtremeTemperatureNotifier {
  List<ExtremeTemperatureSubscriber> extremeSubs = [];

  void notifyOverheat();
  void onOverheatStopped();

  void notifyExtremeCold();
  void onExtremeColdStopped();

  void addExtremeSub(ExtremeTemperatureSubscriber sub);
  void removeExtremeSub(ExtremeTemperatureSubscriber sub);
}
