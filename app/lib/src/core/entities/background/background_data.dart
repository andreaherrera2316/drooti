import 'package:app/src/core/entities/background/background_type.dart';

class BackgroundData {
  BackgroundData({
    required this.asset,
    required this.backgroundColor,
    required this.bgType,
  });

  BackgroundData.rive({
    required this.asset,
    required this.backgroundColor,
    this.bgType = BackgroundType.rive,
  });

  String asset;
  int backgroundColor;
  BackgroundType bgType;
}
