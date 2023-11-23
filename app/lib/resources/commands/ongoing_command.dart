import 'package:app/resources/commands/command.dart';

abstract class OngoingCommand implements Command {
  void cancel();
}
