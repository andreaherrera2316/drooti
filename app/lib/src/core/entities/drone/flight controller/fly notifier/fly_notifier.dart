import 'fly_subscriber.dart';

abstract class FlyNotifier {
  List<FlySubscriber> flySubs = [];

  void flyUpdate();
  void addFlySub(FlySubscriber sub);
  void removeFlySub(FlySubscriber sub);
}
