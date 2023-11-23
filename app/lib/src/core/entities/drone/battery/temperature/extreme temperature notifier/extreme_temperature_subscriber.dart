import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/extreme%20cold/extreme_cold_subscriber.dart';
import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/overheat/overheat_subscriber.dart';

abstract class ExtremeTemperatureSubscriber
    implements OverheatSubscriber, ExtremeColdSubscriber {}
