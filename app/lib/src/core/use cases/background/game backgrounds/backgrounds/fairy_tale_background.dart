import 'package:app/src/core/entities/background/background_data.dart';
import 'package:app/src/core/entities/background/igame_background.dart';

class FairyTaleBackground implements IGameBackground {
  FairyTaleBackground()
      : id = "fairy_tale",
        mainDisplayImg = '/images/backgrounds/fairy_tale_day.jpg',
        wildcard = BackgroundData.rive(
          asset: "fairy_tale_wildcard",
          backgroundColor: 0xFF44A1FE,
        ),
        backgroundVariants = [
          BackgroundData.rive(
            asset: "fairy_tale_day",
            backgroundColor: 0xFF44A1FE,
          ),
          BackgroundData.rive(
            asset: "fairy_tale_night",
            backgroundColor: 0xFF3434E4,
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
