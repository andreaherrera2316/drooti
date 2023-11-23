import 'package:app/src/core/use%20cases/background/available%20backgrounds/boundaries/input_available_backgrounds.dart';
import 'package:app/src/core/use%20cases/background/available%20backgrounds/boundaries/output_available_backgrounds.dart';
import 'package:app/src/core/use%20cases/background/game%20backgrounds/game_backgrounds.dart';

class AvailableBackgrounds implements InputAvailableBackgrounds {
  @override
  void requestBackgrounds(OutputAvailableBackgrounds output) {
    output.recieveBackgrounds(GameBackgrounds().getBackgrounds());
  }
}
