import 'package:app/src/views/screens/game/controller/game%20size%20notifier/game_size_subscriber.dart';

abstract class GameSizeNotifier {
  List<GameSizeSubscriber> sizeSubs = [];
  void notifyResize(double screenHeightInPixels, double screenWidthInPixels);
  void addSizeSub(GameSizeSubscriber sub);
  void removeSizeSub(GameSizeSubscriber sub);
}

//todo: do we need this