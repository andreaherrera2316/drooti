import 'package:app/src/core/entities/background/background_data.dart';
import 'package:app/src/core/entities/background/igame_background.dart';

class IslandBackground implements IGameBackground {
  IslandBackground()
      : id = "island",
        mainDisplayImg = '/images/backgrounds/island_day.jpg',
        wildcard = BackgroundData.rive(
          asset: "island_wildcard",
          backgroundColor: 0xFF55C8FF,
        ),
        backgroundVariants = [
          BackgroundData.rive(
            asset: "island_day",
            backgroundColor: 0xFF55C8FF,
          ),
          BackgroundData.rive(
            asset: "island_night",
            backgroundColor: 0xFF000153,
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
