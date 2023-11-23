import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meters_limit.dart';

abstract class MeterLimitsSubscriber {
  void onLimitsUpdate(MeterLimits limits);
}
