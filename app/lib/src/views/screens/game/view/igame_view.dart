import 'package:app/src/views/screens/game/view%20model/game_view_model.dart';
import 'package:app/src/views/screens/game/view/game%20/game%20data%20display%20/seasons%20display/season%20alert%20notifier/iseason_alert_notifier.dart';

abstract class IGameView implements ISeasonAlertNotifier {
  IGameView({required this.viewModel});
  GameViewModel viewModel;

  void updateGameData();
  void updateBgVariant(String variant, int color);

  void droneFreezing();
  void droneOverheating();
  void droneStoppedFreezing();
  void droneStopedOverheating();

  void explodeDrone();
  void freezeDrone();
  void droneOutOfPower();
  void droneBatteryDied();
  void droneMotorBroke();
  void quantumSpeed();
}
