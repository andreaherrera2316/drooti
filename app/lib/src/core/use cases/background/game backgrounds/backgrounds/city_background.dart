import 'package:app/src/core/entities/background/background_data.dart';
import 'package:app/src/core/entities/background/igame_background.dart';

class CityBackground implements IGameBackground {
  CityBackground()
      : id = "city",
        mainDisplayImg = '/images/backgrounds/future_city_night.jpg',
        wildcard = BackgroundData.rive(
          asset: "city_wildcard",
          backgroundColor: 0xFF0B0C1E,
        ),
        backgroundVariants = [
          BackgroundData.rive(
            asset: "city_day",
            backgroundColor: 0xFF0AAAE4,
          ),
          BackgroundData.rive(
            asset: "city_sunset",
            backgroundColor: 0xFF156D91,
          ),
          BackgroundData.rive(
            asset: "city_night",
            backgroundColor: 0xFF151748,
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
