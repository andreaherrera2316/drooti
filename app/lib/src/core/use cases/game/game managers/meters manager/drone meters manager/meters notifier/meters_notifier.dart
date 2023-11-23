import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/drone%20meters%20manager/meters%20notifier/imeters_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/drone%20meters%20manager/meters%20notifier/meters_subscriber.dart';

class MetersNotifier implements IMetersNotifier {
  @override
  List<MetersSubscriber> metersSubs = [];

  @override
  void addMetersSub(MetersSubscriber sub) {
    metersSubs.add(sub);
  }

  @override
  void removeMetersSub(MetersSubscriber sub) {
    metersSubs.remove(sub);
  }

  @override
  void updateMeters(double meters, double pixelsPerMeter) {
    // Notify all the meters subscribers about the meter update event.
    for (var sub in metersSubs) {
      sub.onMetersUpdate(meters, pixelsPerMeter);
    }
  }
}
