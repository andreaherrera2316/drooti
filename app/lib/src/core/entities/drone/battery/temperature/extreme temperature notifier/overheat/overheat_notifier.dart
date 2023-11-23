import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/overheat/overheat_subscriber.dart';

abstract class OverheatNotifier {
  List<OverheatSubscriber> overheatSubs = [];

  void notifyOverheat();
  void noMoreOverheat();

  void addOverheat(OverheatSubscriber sub);
  void removeOverheat(OverheatSubscriber sub);
}
