class ValWithinLimit {
  static final withinLimit = ValWithinLimit._getInstance();
  factory ValWithinLimit() {
    return withinLimit;
  }

  ValWithinLimit._getInstance();

  double getValue({required double value, required double min, double? max}) {
    if (value < min) {
      return min;
    } else {
      if (max != null && value > max) {
        return max;
      } else {
        return value;
      }
    }
  }
}


//todo: test the resources 