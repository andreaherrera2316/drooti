import 'dart:math';

class RandomCoordinate {
  static final _singleton = RandomCoordinate._new();

  factory RandomCoordinate() {
    return _singleton;
  }
  RandomCoordinate._new();

  double getRandomCoordinate(double spriteSize, double screen) {
    double min = spriteSize * 0.55;
    double max = screen - spriteSize * 0.55;
    return Random(min.round()).nextInt(max.round()).toDouble();
  }
}
