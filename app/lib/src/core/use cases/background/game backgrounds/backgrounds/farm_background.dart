import 'package:app/src/core/entities/background/background_data.dart';
import 'package:app/src/core/entities/background/igame_background.dart';

class FarmBackground implements IGameBackground {
  FarmBackground()
      : id = "farm",
        mainDisplayImg = '/images/backgrounds/farm_day.jpg',
        wildcard = BackgroundData.rive(
          asset: "farm_wildcard",
          backgroundColor: 0Xff2FA4D6,
        ),
        backgroundVariants = [
          BackgroundData.rive(
            asset: "farm_day",
            backgroundColor: 0xFF2FA4D6,
          ),
          BackgroundData.rive(
            asset: "farm_night",
            backgroundColor: 0xFF001A71,
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
