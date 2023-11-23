import 'background_data.dart';

abstract class IGameBackground {
  IGameBackground({
    required this.id,
    required this.mainDisplayImg,
    required this.wildcard,
    required this.backgroundVariants,
  });

  String id;
  String mainDisplayImg;
  BackgroundData wildcard;

  ///every background will have variants such as: day, night etc.
  ///the main display img should be the image we how the user
  ///then the wildcard is the coolest rarest variant
  List<BackgroundData> backgroundVariants;
}
