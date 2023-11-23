import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20manager/meter%20limits%20notifier/imeter_limits_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20manager/meter%20limits%20notifier/meter_limits_subscriber.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meters_limit.dart';

class MeterLimitsNotifier implements IMeterLimitsNotifier {
  @override
  List<MeterLimitsSubscriber> limitsSubs = [];

  @override
  void addLimitsSub(MeterLimitsSubscriber sub) {
    limitsSubs.add(sub);
  }

  @override
  void removeLimitsSub(MeterLimitsSubscriber sub) {
    limitsSubs.remove(sub);
  }

  @override
  void meterLimitsUpdate(MeterLimits meterLimits) {
    for (var sub in limitsSubs) {
      sub.onLimitsUpdate(meterLimits);
    }
  }
}
