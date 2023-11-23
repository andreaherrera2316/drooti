import 'package:app/src/core/entities/game/weather/temperature.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/yearly%20seasons/autumn.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/yearly%20seasons/spring.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/yearly%20seasons/summer.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/yearly%20seasons/winter.dart';

abstract class IGameSeasonsManager {
  IGameSeasonsManager({
    required this.seasonDuration,
    required this.temperature,
  });

  Temperature temperature;
  Duration seasonDuration;
  List<Season> seasons = [
    Spring(),
    Summer(),
    Autumn(),
    Winter(),
  ];
}
