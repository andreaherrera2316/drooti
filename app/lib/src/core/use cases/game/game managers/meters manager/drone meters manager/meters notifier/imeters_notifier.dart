import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/drone%20meters%20manager/meters%20notifier/meters_subscriber.dart';

abstract class IMetersNotifier {
  List<MetersSubscriber> metersSubs = [];
  void updateMeters(double meters, double pixelsPerMeter);
  void addMetersSub(MetersSubscriber sub);
  void removeMetersSub(MetersSubscriber sub);
}
