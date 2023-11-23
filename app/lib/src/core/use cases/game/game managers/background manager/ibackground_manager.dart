// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/src/core/use%20cases/game/game%20managers/igame_manager.dart';
import 'package:app/src/views/background/variant%20notifier/ibackground_variant_notifier.dart';

abstract class IBackgroundManager
    implements IGameManager, IBackgroundVariantNotifier {
  String get backgroundVariant;
  int get backgroundColor;
}
