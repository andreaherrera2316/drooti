import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/drone%20meters%20manager/meters%20notifier/meters_subscriber.dart';
import 'package:app/src/views/screens/game/presenter/igame_presenter.dart';

class ProcessMetersUpdates implements MetersSubscriber {
  ProcessMetersUpdates({required this.presenter});
  IGamePresenter presenter;

  @override
  void onMetersUpdate(double meters, double pixelsPerMeter) {
    presenter.setMetersTravelled(meters);
  }
}
