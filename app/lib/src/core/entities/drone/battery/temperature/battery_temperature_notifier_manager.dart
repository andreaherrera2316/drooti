import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/extreme_temperature_notifier.dart';
import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/extreme_temperature_subscriber.dart';
import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/extreme_temperature_tracker.dart';
import 'package:app/src/core/entities/game/weather/temperature.dart';

import '../resistance/temperature_resistance.dart';

class BatteryTemperatureNotifierManager
    with ExtremeTemperatureTracker
    implements ExtremeTemperatureNotifier {
  BatteryTemperatureNotifierManager(
      {required this.temperature, required this.resistance});
  Temperature temperature;
  TemperatureResistance resistance;

  bool get overheat => checkOverheat(resistance, temperature);
  bool get extremeCold => checkExtremeCold(resistance, temperature);

  int get _maxTemperatureExceededBy =>
      getMaxTemperatureExceededBy(resistance, temperature);

  int get _minTemperatureBelowBy =>
      getMinTemperatureBelowBy(resistance, temperature);

  @override
  List<ExtremeTemperatureSubscriber> extremeSubs = [];

  @override
  void addExtremeSub(ExtremeTemperatureSubscriber sub) {
    extremeSubs.add(sub);
    checkForExtremeTemperature();
  }

  @override
  void removeExtremeSub(ExtremeTemperatureSubscriber sub) {
    extremeSubs.remove(sub);
  }

  @override
  void notifyOverheat() {
    for (var sub in extremeSubs) {
      sub.onOverheat(temperature, _maxTemperatureExceededBy);
    }
  }

  @override
  void onOverheatStopped() {
    for (var sub in extremeSubs) {
      sub.onOverheatStopped(temperature);
    }
  }

  @override
  void onExtremeColdStopped() {
    for (var sub in extremeSubs) {
      sub.onExtremeColdStopped(temperature);
    }
  }

  @override
  void notifyExtremeCold() {
    for (var sub in extremeSubs) {
      sub.onExtremeCold(temperature, _minTemperatureBelowBy);
    }
  }

  void checkForExtremeTemperature() {
    if (overheat) {
      notifyOverheat();
    } else if (extremeCold) {
      onOverheatStopped();
    }
  }

  void checkPreviousExtremeTemp(Temperature previous, Temperature current) {
    bool noMoreOverheat = checkOverheatStopped(previous, current, resistance);
    if (noMoreOverheat) {
      onOverheatStopped();
      return;
    }

    bool extremeColdStopped =
        checkExtremeColdStopped(previous, current, resistance);
    if (extremeColdStopped) {
      onExtremeColdStopped();
    }
  }
}
