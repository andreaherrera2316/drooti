class RoundDecimalPlaces {
  static final _instance = RoundDecimalPlaces._getInstace();
  factory RoundDecimalPlaces() => _instance;
  RoundDecimalPlaces._getInstace();

  double decimalPlaces(double amount, int decimals) {
    var round = amount.toStringAsFixed(decimals);
    return double.parse(round);
  }
}
