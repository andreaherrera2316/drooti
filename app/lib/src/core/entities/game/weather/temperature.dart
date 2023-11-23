class Temperature {
  static final zero = Temperature(0);

  Temperature(int temperatureF) : _temperatureF = temperatureF;

  int _temperatureF;
  int get temperatureF => _temperatureF;

  void adjustTemperature(int amount) {
    _temperatureF += amount;
  }

  void setTemperature(int newTemperature) {
    _temperatureF = newTemperature;
  }
}
