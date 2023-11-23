import 'package:app/src/core/use%20cases/background/available%20backgrounds/available_backgrounds.dart';

import '../presenter/ipick_background_presenter.dart';
import 'ipick_background_controller.dart';

class PickBackgroundController implements IPickBackgroundController {
  PickBackgroundController({
    required this.presenter,
  });
  IPickBackgroundPresenter presenter;

  @override
  void getBackgrounds() {
    AvailableBackgrounds().requestBackgrounds(presenter);
  }

  @override
  void goToGame() {
    presenter.goToGame();
  }

  @override
  void selectBackground(String backgroundID) {
    presenter.selectBackground(backgroundID);
  }

  @override
  void unselectBackground() {
    presenter.unselectBackground();
  }
}
