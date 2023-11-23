abstract class ISeasonAlertNotifier {
  List<ISeasonAlertSubscriber> alertSubs = [];
  void autumn();
  void spring();
  void summer();
  void winter();
  void addAlertSub(ISeasonAlertSubscriber sub) {
    alertSubs.add(sub);
  }

  void removeAlertSub(ISeasonAlertSubscriber sub) {
    alertSubs.remove(sub);
  }
}

abstract class ISeasonAlertSubscriber {
  void autumn();
  void spring();
  void summer();
  void winter();
}
