import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/extreme%20cold/extreme_cold_subscriber.dart';

abstract class ExtremeColdNotifier {
  List<ExtremeColdSubscriber> coldSubs = [];

  void notifyExtremeCold();
  void noMoreExtremeCold();

  void addCold(ExtremeColdSubscriber sub);
  void removeCold(ExtremeColdSubscriber sub);
}
