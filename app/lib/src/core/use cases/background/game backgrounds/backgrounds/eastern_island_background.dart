import 'package:app/src/core/entities/background/background_data.dart';
import 'package:app/src/core/entities/background/igame_background.dart';

class EasternIslandBackground implements IGameBackground {
  EasternIslandBackground()
      : id = "eastern_island",
        mainDisplayImg = '/images/backgrounds/eastern_island_day.jpg',
        wildcard = BackgroundData.rive(
          asset: "eastern_island_wildcard",
          backgroundColor: 0xFF5A5E9D,
        ),
        backgroundVariants = [
          BackgroundData.rive(
            asset: "eastern_island_day",
            backgroundColor: 0xFF5982FF,
          ),
          BackgroundData.rive(
            asset: "eastern_island_sunrise",
            backgroundColor: 0xFFBFCAE0,
          ),
          BackgroundData.rive(
            asset: "eastern_island_sunset",
            backgroundColor: 0xFF8939CF,
          ),
          BackgroundData.rive(
            asset: "eastern_island_night",
            backgroundColor: 0xFF1D0553,
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
