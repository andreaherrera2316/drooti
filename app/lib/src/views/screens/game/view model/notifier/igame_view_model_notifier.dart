import 'package:app/src/views/screens/game/view%20model/notifier/igame_view_model_subscriber.dart';

abstract class IGameViewModelNotifier {
  List<IGameViewModelSubscriber> modelSubs = [];

  void addModelSub(IGameViewModelSubscriber sub);
  void removeModelSub(IGameViewModelSubscriber sub);
  void onViewModelUpdate();
}
