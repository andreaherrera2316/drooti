class TemperatureResistance {
  TemperatureResistance({
    required int minTemperature,
    required int maxTemperature,
  })  : _minTemperature = minTemperature,
        _maxTemperature = _getMax(minTemperature, maxTemperature);

  static int _getMax(int min, int max) {
    if (max > min) {
      return max;
    }

    return min + 1;
  }

  final int _minTemperature;
  final int _maxTemperature;

  int get minTemperature => _minTemperature;

  int get maxTemperature => _maxTemperature;
}
