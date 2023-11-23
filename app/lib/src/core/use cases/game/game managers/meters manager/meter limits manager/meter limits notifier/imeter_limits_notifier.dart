import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20manager/meter%20limits%20notifier/meter_limits_subscriber.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meters_limit.dart';

abstract class IMeterLimitsNotifier {
  List<MeterLimitsSubscriber> limitsSubs = [];
  void meterLimitsUpdate(MeterLimits meterLimits);
  void addLimitsSub(MeterLimitsSubscriber sub);
  void removeLimitsSub(MeterLimitsSubscriber sub);
}
