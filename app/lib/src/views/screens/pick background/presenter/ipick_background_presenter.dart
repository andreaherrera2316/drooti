import 'package:app/src/core/use%20cases/background/available%20backgrounds/boundaries/output_available_backgrounds.dart';

abstract class IPickBackgroundPresenter implements OutputAvailableBackgrounds {
  void selectBackground(String backgroundID);
  void unselectBackground();
  void goToGame();
}
