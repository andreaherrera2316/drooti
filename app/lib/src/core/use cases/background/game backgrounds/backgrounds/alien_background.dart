import 'package:app/src/core/entities/background/background_data.dart';
import 'package:app/src/core/entities/background/igame_background.dart';

class AlienBackground implements IGameBackground {
  //todo: create an images file

  AlienBackground()
      : id = "alien",
        mainDisplayImg = '/images/backgrounds/alien_day.jpg',
        wildcard = BackgroundData.rive(
          asset: "alien_wildcard",
          backgroundColor: 0xFF2A1E80,
        ),
        backgroundVariants = [
          BackgroundData.rive(
            asset: "alien_day",
            backgroundColor: 0xFFEA61BD,
          ),
          BackgroundData.rive(
            asset: "alien_night",
            backgroundColor: 0xFF2A1E80,
          ),
        ] {
    backgroundVariants.add(wildcard);
  }

  @override
  String id;

  @override
  String mainDisplayImg;

  @override
  BackgroundData wildcard;

  @override
  List<BackgroundData> backgroundVariants;
}
