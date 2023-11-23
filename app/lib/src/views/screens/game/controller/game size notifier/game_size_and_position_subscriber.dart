import 'package:app/src/views/screens/game/controller/game%20size%20notifier/game_size_and_direction_subscriber.dart';

abstract class GameSizeAndPositonSubscriber
    implements GameSizeAndDirectionSubscriber {
  @override
  void onGameResize(
    double heightInPixels,
    double widthInPixels, [
    bool topToBottom = true,
    double? drootiX,
    double? drootiY,
  ]);
}
