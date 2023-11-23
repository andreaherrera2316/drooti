import 'package:app/src/views/screens/game/view%20model/game_view_model.dart';
import 'package:app/src/views/screens/game/view%20model/notifier/igame_view_model_notifier.dart';
import 'package:app/src/views/screens/game/view%20model/notifier/igame_view_model_subscriber.dart';

class ViewModelNotifier implements IGameViewModelNotifier {
  ViewModelNotifier({required GameViewModel viewModel})
      : _viewModel = viewModel;

  GameViewModel _viewModel;

  set setViewModel(GameViewModel viewModel) {
    _viewModel = viewModel;
    onViewModelUpdate();
  }

  @override
  List<IGameViewModelSubscriber> modelSubs = [];

  @override
  void addModelSub(IGameViewModelSubscriber sub) {
    modelSubs.add(sub);
  }

  @override
  void onViewModelUpdate() {
    for (var sub in modelSubs) {
      sub.onViewmodelUpdate(_viewModel);
    }
  }

  @override
  void removeModelSub(IGameViewModelSubscriber sub) {
    modelSubs.remove(sub);
  }
}
