import 'package:app/src/views/screens/game/view%20model/game_view_model.dart';

abstract class IGameViewModelSubscriber {
  onViewmodelUpdate(GameViewModel model);
}
