import 'package:app/src/views/screens/game/view/game%20/game%20data%20display%20/seasons%20display/season%20alert%20notifier/iseason_alert_notifier.dart';

class SeasonAlerts implements ISeasonAlertNotifier {
  @override
  List<ISeasonAlertSubscriber> alertSubs = [];
  @override
  void autumn() {
    for (var sub in alertSubs) {
      sub.autumn();
    }
  }

  @override
  void spring() {
    for (var sub in alertSubs) {
      sub.spring();
    }
  }

  @override
  void summer() {
    for (var sub in alertSubs) {
      sub.summer();
    }
  }

  @override
  void winter() {
    for (var sub in alertSubs) {
      sub.winter();
    }
  }

  @override
  void addAlertSub(ISeasonAlertSubscriber sub) {
    alertSubs.add(sub);
  }

  @override
  void removeAlertSub(ISeasonAlertSubscriber sub) {
    alertSubs.remove(sub);
  }
}
