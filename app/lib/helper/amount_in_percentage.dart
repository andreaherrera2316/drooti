class AmountInPercentage {
  static final _instace = AmountInPercentage._getInstance();

  factory AmountInPercentage() {
    return _instace;
  }

  AmountInPercentage._getInstance();

  double getPercent({required num amount, required num total}) {
    if (total == 0) {
      return 0;
    }
    return amount / total * 100;
  }
}
