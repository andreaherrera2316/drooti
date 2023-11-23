class PercentageInAmount {
  static final percentInAmount = PercentageInAmount._getInstance();
  factory PercentageInAmount() {
    return percentInAmount;
  }

  PercentageInAmount._getInstance();

  double getAmount({required double percent, required double totalAmount}) {
    return totalAmount * percent / 100;
  }
}
